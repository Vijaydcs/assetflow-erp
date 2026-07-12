# AssetFlow ERP

Enterprise Asset & Resource Management System developed for the Odoo Hackathon 2026.

AssetFlow is a centralized platform for managing organizational assets throughout their lifecycle. It enables asset registration, allocation, maintenance, resource booking, auditing, reporting, and operational monitoring through a simple and intuitive interface.

## Screenshots

<img src="assets/dashboard.png" width="100%">

<img src="assets/assets.png" width="100%">

<img src="assets/maintenance.png" width="100%">

<img src="assets/reports.png" width="100%">

## Features

- Dashboard with real-time asset overview
- Asset registration and tracking
- Asset allocation and transfer management
- Resource booking with conflict detection
- Maintenance request management
- Asset audit workflow
- Reports and analytics
- Notification center
- REST API integration with Spring Boot

## Tech Stack

Frontend
- React
- Vite
- TypeScript

Backend
- Spring Boot
- Spring Data JPA
- Spring Security

Database
- PostgreSQL

## Project Structure

```text
assetflow-erp
├── frontend
├── backend
├── database
├── docs
└── README.md
```

## Getting Started

Clone the repository

```bash
git clone https://github.com/Vijaydcs/assetflow-erp.git
cd assetflow-erp
```

Frontend

```bash
cd frontend
npm install
npm run dev
```

Backend

```bash
cd backend
mvn spring-boot:run
```

Frontend

```
http://localhost:5174
```

Backend

```
http://localhost:8080
```

## API

GET `/api/dashboard`

Returns dashboard statistics, asset details, and recent activities.

## Future Improvements

- Complete PostgreSQL integration
- Role-based authentication
- QR/Barcode support
- Asset lifecycle automation
- Email notifications
- Advanced analytics dashboard

## Team

Vijay D  
Team Lead

Hima Heer  
Team Member
