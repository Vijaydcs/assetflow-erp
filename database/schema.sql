-- AssetFlow ERP PostgreSQL schema
-- Run: createdb assetflow && psql -d assetflow -f database/schema.sql

CREATE TYPE user_role AS ENUM ('ADMIN', 'ASSET_MANAGER', 'DEPARTMENT_HEAD', 'EMPLOYEE');
CREATE TYPE asset_status AS ENUM ('AVAILABLE', 'ALLOCATED', 'RESERVED', 'UNDER_MAINTENANCE', 'LOST', 'RETIRED', 'DISPOSED');
CREATE TYPE allocation_status AS ENUM ('ACTIVE', 'RETURNED', 'TRANSFER_REQUESTED', 'TRANSFER_APPROVED', 'CANCELLED');
CREATE TYPE booking_status AS ENUM ('UPCOMING', 'ONGOING', 'COMPLETED', 'CANCELLED');
CREATE TYPE maintenance_status AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'TECHNICIAN_ASSIGNED', 'IN_PROGRESS', 'RESOLVED');
CREATE TYPE audit_status AS ENUM ('DRAFT', 'IN_PROGRESS', 'CLOSED');
CREATE TYPE verification_status AS ENUM ('PENDING', 'VERIFIED', 'MISSING', 'DAMAGED');

CREATE TABLE departments (
  id BIGSERIAL PRIMARY KEY, name VARCHAR(120) NOT NULL UNIQUE, parent_id BIGINT REFERENCES departments(id),
  is_active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY, full_name VARCHAR(150) NOT NULL, email VARCHAR(254) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL, role user_role NOT NULL DEFAULT 'EMPLOYEE', department_id BIGINT REFERENCES departments(id),
  is_active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE asset_categories (
  id BIGSERIAL PRIMARY KEY, name VARCHAR(120) NOT NULL UNIQUE, warranty_months INTEGER CHECK (warranty_months >= 0),
  is_active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE assets (
  id BIGSERIAL PRIMARY KEY, asset_tag VARCHAR(30) NOT NULL UNIQUE, name VARCHAR(180) NOT NULL,
  serial_number VARCHAR(120) UNIQUE, category_id BIGINT NOT NULL REFERENCES asset_categories(id),
  department_id BIGINT REFERENCES departments(id), acquisition_date DATE, acquisition_cost NUMERIC(12,2) CHECK (acquisition_cost >= 0),
  asset_condition VARCHAR(30) NOT NULL DEFAULT 'GOOD', location VARCHAR(160) NOT NULL, is_bookable BOOLEAN NOT NULL DEFAULT FALSE,
  status asset_status NOT NULL DEFAULT 'AVAILABLE', health_score SMALLINT NOT NULL DEFAULT 100 CHECK (health_score BETWEEN 0 AND 100),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE allocations (
  id BIGSERIAL PRIMARY KEY, asset_id BIGINT NOT NULL REFERENCES assets(id), employee_id BIGINT REFERENCES users(id),
  department_id BIGINT REFERENCES departments(id), allocated_by BIGINT NOT NULL REFERENCES users(id), allocated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  expected_return_date DATE, returned_at TIMESTAMPTZ, return_notes TEXT, status allocation_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT allocation_target CHECK (employee_id IS NOT NULL OR department_id IS NOT NULL)
);
CREATE UNIQUE INDEX one_active_allocation_per_asset ON allocations(asset_id) WHERE status = 'ACTIVE';
CREATE INDEX allocations_overdue_idx ON allocations(expected_return_date) WHERE status = 'ACTIVE';
CREATE TABLE transfer_requests (
  id BIGSERIAL PRIMARY KEY, allocation_id BIGINT NOT NULL REFERENCES allocations(id), requested_by BIGINT NOT NULL REFERENCES users(id),
  target_employee_id BIGINT REFERENCES users(id), target_department_id BIGINT REFERENCES departments(id), reason TEXT, status allocation_status NOT NULL DEFAULT 'TRANSFER_REQUESTED',
  approved_by BIGINT REFERENCES users(id), created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), decided_at TIMESTAMPTZ
);
CREATE TABLE resource_bookings (
  id BIGSERIAL PRIMARY KEY, asset_id BIGINT NOT NULL REFERENCES assets(id), booked_by BIGINT NOT NULL REFERENCES users(id),
  department_id BIGINT REFERENCES departments(id), starts_at TIMESTAMPTZ NOT NULL, ends_at TIMESTAMPTZ NOT NULL, purpose VARCHAR(255),
  status booking_status NOT NULL DEFAULT 'UPCOMING', created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), CHECK (ends_at > starts_at)
);
CREATE INDEX booking_overlap_lookup_idx ON resource_bookings(asset_id, starts_at, ends_at) WHERE status <> 'CANCELLED';
CREATE TABLE maintenance_requests (
  id BIGSERIAL PRIMARY KEY, asset_id BIGINT NOT NULL REFERENCES assets(id), requested_by BIGINT NOT NULL REFERENCES users(id),
  description TEXT NOT NULL, priority VARCHAR(12) NOT NULL CHECK(priority IN ('LOW','MEDIUM','HIGH','CRITICAL')),
  status maintenance_status NOT NULL DEFAULT 'PENDING', technician_id BIGINT REFERENCES users(id), approved_by BIGINT REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), resolved_at TIMESTAMPTZ, resolution_notes TEXT
);
CREATE TABLE audit_cycles (
  id BIGSERIAL PRIMARY KEY, name VARCHAR(160) NOT NULL, department_id BIGINT REFERENCES departments(id), location VARCHAR(160),
  starts_on DATE NOT NULL, ends_on DATE NOT NULL, status audit_status NOT NULL DEFAULT 'DRAFT', created_by BIGINT NOT NULL REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), CHECK(ends_on >= starts_on)
);
CREATE TABLE audit_items (
  id BIGSERIAL PRIMARY KEY, audit_cycle_id BIGINT NOT NULL REFERENCES audit_cycles(id) ON DELETE CASCADE, asset_id BIGINT NOT NULL REFERENCES assets(id),
  auditor_id BIGINT REFERENCES users(id), verification verification_status NOT NULL DEFAULT 'PENDING', notes TEXT, verified_at TIMESTAMPTZ,
  UNIQUE(audit_cycle_id, asset_id)
);
CREATE TABLE notifications (
  id BIGSERIAL PRIMARY KEY, user_id BIGINT NOT NULL REFERENCES users(id), title VARCHAR(180) NOT NULL, message TEXT NOT NULL,
  read_at TIMESTAMPTZ, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE activity_logs (
  id BIGSERIAL PRIMARY KEY, actor_id BIGINT REFERENCES users(id), action VARCHAR(120) NOT NULL, entity_type VARCHAR(60) NOT NULL,
  entity_id BIGINT, details JSONB NOT NULL DEFAULT '{}'::jsonb, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Rules enforced in the API: do not allocate non-AVAILABLE assets; reject booking when
-- an existing booking satisfies starts_at < requestedEnd AND ends_at > requestedStart.
