# AssetFlow ERP

Enterprise Asset & Resource Management System developed for the Odoo Hackathon 2026.

AssetFlow is a centralized platform for managing organizational assets throughout their lifecycle. It enables asset registration, allocation, maintenance, resource booking, auditing, reporting, and operational monitoring through a simple and intuitive interface.

## Screenshots

<img width="1600" height="800" alt="image" src="https://github.com/user-attachments/assets/dcd8b9b0-8c0f-40f9-b7e3-aba2d072ce79" />


<img width="1600" height="775" alt="image" src="https://github.com/user-attachments/assets/d3936eb4-edce-4b7c-a646-e2953f5d324a" />


<img width="1600" height="766" alt="image" src="https://github.com/user-attachments/assets/88628860-81e8-4bc9-bba8-3579802ed652" />


<img width="1600" height="758" alt="image" src="https://github.com/user-attachments/assets/0cf65c9a-595e-4d92-bc74-1a1d50246949" />


<img width="1600" height="759" alt="image" src="https://github.com/user-attachments/assets/82e4c9c0-bdad-4ff6-9939-b3561e97e09d" />


<img width="1600" height="828" alt="image" src="https://github.com/user-attachments/assets/6379503f-d0db-4aae-bbac-5d2037038b26" />


<img width="1600" height="760" alt="image" src="https://github.com/user-attachments/assets/aedabfc2-def4-47e1-97a5-7a524b49eb4c" />


<img width="1600" height="769" alt="image" src="https://github.com/user-attachments/assets/e6f8c793-0ea6-4da9-acef-6034fef128a0" />


<img width="1600" height="760" alt="image" src="https://github.com/user-attachments/assets/804951b5-fba6-4390-a971-339aa8247a95" />



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

Member 1 : Vijay D  
Member 2 : Hima Heer  
