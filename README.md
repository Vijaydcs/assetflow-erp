# AssetFlow ERP

Enterprise Asset and Resource Management System for the Odoo Hackathon 2026.

AssetFlow centralizes asset registration, allocation, booking, maintenance, audits, reporting and notifications. Its Manager Action Center turns operational data into prioritized next actions.

## Stack

- Frontend: React, Vite, TypeScript
- Backend: Spring Boot, Spring Data JPA, Spring Security
- Database: PostgreSQL

## Current build

The React interface includes a complete interactive ERP demo: dashboard, master-data directory, asset registration, allocation/return workflow, maintenance board, booking overlap validation, audit, reports and notifications.

```powershell
cd frontend
pnpm install
pnpm dev
```

## Local backend setup

1. Install JDK 21, Maven and PostgreSQL 16+.
2. Create the `assetflow` database and run `database/schema.sql`.
3. Set `DATABASE_USER` and `DATABASE_PASSWORD` if they differ from the defaults.
4. Run `mvn spring-boot:run` from `backend`.

See [docs/IMPLEMENTATION.md](docs/IMPLEMENTATION.md) for the demo path and API implementation plan.
