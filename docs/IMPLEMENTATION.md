# AssetFlow ERP implementation guide

## Source of truth

1. The official AssetFlow problem statement defines the mandatory business behaviour.
2. The supplied mockups define the UI layout and navigation.
3. This repository's PostgreSQL schema defines persistence and data constraints.

## MVP demo path

1. Register an asset as `AVAILABLE`.
2. Allocate it to an employee, recording an expected return date.
3. Attempt a second allocation and show the conflict message/transfer option.
4. Return the asset and confirm it becomes `AVAILABLE`.
5. Raise and approve maintenance; it becomes `UNDER_MAINTENANCE`.
6. Resolve maintenance; it returns to `AVAILABLE`.
7. Show refreshed dashboard KPIs and the Manager Action Center.

## Required API modules

- `/api/auth`: signup creates `EMPLOYEE` only; roles are changed only by an admin.
- `/api/departments`, `/api/categories`, `/api/users`: admin master-data CRUD.
- `/api/assets`: directory, filters, registration and lifecycle history.
- `/api/allocations`: allocation, return and transfer workflow.
- `/api/bookings`: overlap validation (`existing.start < requested.end` AND `existing.end > requested.start`).
- `/api/maintenance`: approval state machine and asset status side effects.
- `/api/dashboard`: server-calculated KPI and Action Center payload.

## Demo-mode caveat

The current React screen is deliberately interactive with seeded browser data so it can be demonstrated before the local Java/PostgreSQL runtimes are installed. Replace its state calls with Axios API calls when the Spring API is running. Do not keep demo-only data for submission.
