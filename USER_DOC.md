# 📖 User Guide

## 1. Project Access

Once the infrastructure is running, the services are available through your browser:

- **Main Website (WordPress)**  
  https://ybassour.42.fr

- **Adminer (Database Management)**  
  https://ybassour.42.fr/adminer

- **cAdvisor (Container Monitoring)**  
  https://ybassour.42.fr/cadvisor

- **static_site (static site)**  
  https://ybassour.42.fr/static_site

---

## 2. First-Time Setup

### WordPress Setup
- Open the main website
- Enter:
  - Username | Email
  - Password
- Login to dashboard and start managing content


### Adminer Login
- System: MySQL / Mariadb
- Server: mariadb  
- Username: (from `.env`)  
- Password: (from `secrets/db_password.txt`)  
- Database: (from `.env`)  


---

## 3. Using the Services

### WordPress
- Create pages, posts, and media  
- Manage themes and plugins  
- Acts as the main website interface  


### Adminer
- Manage database tables  
- Execute SQL queries  
- Inspect WordPress data  


### cAdvisor
- Monitor containers:
  - CPU usage  
  - Memory usage  
  - Network activity  
- Useful for debugging performance issues  


---

## 4. File Management (FTP)

- Connect using an FTP client  
- Host: ybassour.42.fr  
- Username: (from `.env`)  
- Password: (from `secrets/ftp_user_password.txt`)   
- Access WordPress files inside the container volume  


---

## 5. How Routing Works

All services are accessed through a single entry point:

- Nginx listens on **HTTPS (port 443)**  
- It routes requests based on URL path:
  - `/` → WordPress  
  - `/adminer` → Adminer container  
  - `/cadvisor` → cAdvisor container  
  - `/static_site` → static_site 

This means:
- Users never access containers directly  
- Internal services stay private and secure  


---

## 6. Notes on Security

- The project uses a **self-signed TLS certificate**  
- Browsers will show a warning (this is expected)  
- Data is encrypted but not publicly trusted  


---

## 7. Stopping the Project

- Stop all services using Docker Compose  
- Restart by running the build and up process again  


---

## 8. Troubleshooting

### Common Issues

- **Site not loading**  
  → Check if containers are running  

- **Wrong service displayed (WordPress instead of cAdvisor)**  
  → Check Nginx routing configuration  

- **SSL error**  
  → Expected due to self-signed certificate  

- **Database connection failed**  
  → Verify `.env` and MariaDB container  