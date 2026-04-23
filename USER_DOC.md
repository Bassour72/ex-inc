# 📖 User Guide  Documentation

---

# 1. Project Overview
Once the infrastructure is running, the services are available through your browser:
The infrastructure includes:

* Nginx (reverse proxy / entry point)
* WordPress (web application)
* MariaDB (database)
* Adminer (database management)
* cAdvisor (container monitoring)
* Static website service

All services run inside isolated Docker containers and communicate through a private Docker network.

---

# 2. Prerequisites

Required tools:

* Docker Engine
* Docker Compose v2+
* Make
* Git
* sudo privileges

### Verification

```bash
docker --version
docker compose version
make --version
```

---

# 3. Project Setup

### Clone repository

```bash
git clone <repository_url> inception
cd inception
```

---

# 4. Environment Configuration

## 4.1 Environment Variables

Create `.env` file:

```bash
cp .env.example .env
```

Contains:

* Database credentials
* WordPress credentials
* Domain configuration
* FTP configuration

---

## 4.2 Secrets

Stored in:

```
/secrets/
```

Examples:

* db_password.txt
* wp_admin_password.txt
* ftp_user_password.txt

Secrets are injected via Docker secrets and never embedded in images.

---

# 5. Build and Launch

## Using Make

```bash
make
```

## Using Docker Compose

```bash
docker compose up -d --build
```

### Result:

* Images built
* Network created
* Volumes initialized
* Services started

---

# 6. Container Management

### Running containers

```bash
docker ps
```

### Logs

```bash
docker compose logs -f
```

### Stop services

```bash
docker compose stop
```

### Restart services

```bash
docker compose restart
```

### Stop (keep data)

```bash
docker compose down
```

### Full reset (delete data)

```bash
docker compose down -v
```

---

# 7. Data Persistence

Data is stored using Docker volumes:

* MariaDB volume
* WordPress volume

Optional bind mount:

```
/home/${USER}/data
```

System location:

```
/var/lib/docker/volumes/
```

### Rules

* Containers are ephemeral
* Volumes store all persistent data
* Removing volumes deletes data permanently


# 8. Access URLs (User Services)

Once the infrastructure is running, services are accessible via:

- 🌐 **WordPress**  
  https://ybassour.42.fr  

- ⚙️ **WordPress Administration Panel**  
  https://ybassour.42.fr/wp-admin  

- 🗄️ **Adminer**  
  https://ybassour.42.fr/adminer  

- 📊 **cAdvisor**  
  https://ybassour.42.fr/cadvisor  

- 📄 **Static Site**  
  https://ybassour.42.fr/static_site  

---

Users can access the main website, administration panel, and all additional services through their respective URLs.
# 9. Service Architecture

All traffic goes through Nginx (port 443 HTTPS).

Routing:

* / → WordPress
* /adminer → Adminer
* /cadvisor → cAdvisor
* /static_site → static website

Internal communication:

* Nginx → WordPress (FastCGI 9000)
* WordPress → MariaDB (3306)
* Adminer → MariaDB (3306)

No direct container IP usage (DNS-based communication).

---

# 10. First-Time Setup

## WordPress

1. Open main website
2. Create admin account
3. Login to dashboard

## Adminer

* System: MySQL / MariaDB
* Server: mariadb
* Username: from .env
* Password: from secrets
* Database: from .env

---

# 11. FTP Access

Used for file management:

* Host: ybassour.42.fr
* Username: from .env
* Password: from secrets

Used to access WordPress files inside volumes.

---

# 12. Security

* Self-signed TLS certificate used (browser warning expected)
* All traffic encrypted via HTTPS
* Secrets are never included in images

---

# 13. Design Principles

* One service per container
* Stateless application layers
* Persistent storage only via volumes
* Nginx as single entry point
* Configuration via .env and secrets

---

# 14. Troubleshooting

## Site not accessible

* Check running containers

## Wrong service displayed

* Verify Nginx routing

## Database error

* Check .env and MariaDB container

## Missing data

* Ensure volumes were not removed with `down -v`

## SSL warning

* Expected due to self-signed certificate

---

# 15. Important Notes

* Containers are rebuilt on image changes
* No persistent data inside containers
* Volumes are the only storage layer
* Secrets must remain external to images
