# 🛠️ Developer Documentation

This document explains how to set up, build, run, and manage the Inception infrastructure using Docker and Docker Compose.

---

# 1. Project Overview

## Structure

```
.
├── Makefile
├── README.md
├── DEV_DOC.md
├── USER_DOC.md
├── secrets/
├── srcs/
│   ├── docker-compose.yml
│   └── requirements/
```

### Key Files

* `docker-compose.yml` → Defines services, networks, volumes
* `Makefile` → Automates build and lifecycle commands
* `.env` → Stores environment variables
* `secrets/` → Stores sensitive credentials

---

# 2. Architecture

## Core Services

* **nginx** → Reverse proxy (HTTPS entry point)
* **wordpress** → PHP-FPM application
* **mariadb** → Database (persistent storage)

## Bonus Services

* redis → Cache
* ftp → File transfer
* adminer → Database UI
* cadvisor → Monitoring
* static-site → Static content

## Communication

* Services communicate via **Docker network (DNS)**
* No hardcoded IP addresses

---

# 3. Prerequisites

Required tools:

* Docker Engine
* Docker Compose v2+
* Make
* Git
* sudo privileges

### Verify Installation

```
docker --version
docker compose version
make --version
```

---

# 4. Environment Setup

## 4.1 Clone Project

```
git clone <repository_url> inception
cd inception
```

## 4.2 Environment Variables

```
cp .env.example .env
```

Includes:

* Database credentials
* WordPress configuration
* Domain settings
* FTP credentials

## 4.3 Secrets

Stored in:

```
/secrets/
```

Examples:

* db_password.txt
* wp_admin_password.txt
* ftp_user_password.txt

Secrets are injected via Docker and **never stored in images**.

## 4.4 Required Directories

If using bind mounts:

```
/home/${USER}/data/
```

---

# 5. Build and Launch

## Using Makefile

```
make
```

## Using Docker Compose

```
docker compose up -d --build
```

### Result

* Images built
* Network created
* Volumes initialized
* Containers started

---

# 6. Container & Project Management

## Basic Commands

* View running containers:

  ```
  docker ps
  ```

* View logs:

  ```
  docker compose logs -f
  ```

* Stop services:

  ```
  docker compose stop
  ```

* Restart services:

  ```
  docker compose restart
  ```

* Stop (keep data):

  ```
  docker compose down
  ```

* Full reset (delete data):

  ```
  docker compose down -v
  ```

## Using Make

* Full cleanup:

  ```
  make fclean
  ```

---

# 7. Data Storage & Persistence

## Where Data Is Stored

* Docker volumes:

  * MariaDB → `/var/lib/mysql`
  * WordPress → `/var/www/wordpress`

* Host system (optional bind mount):

  ```
  /home/${USER}/data/
  ```

* Docker internal storage:

  ```
  /var/lib/docker/volumes/
  ```

## Persistence Rules

* Containers are **ephemeral**
* Data lives in **volumes only**
* Removing volumes = **permanent data loss**

---

# 8. Networking

## External Access

Only Nginx exposes a port:

```
443:443
```

## Internal Services

| Service   | Port |
| --------- | ---- |
| WordPress | 9000 |
| MariaDB   | 3306 |
| cAdvisor  | 8080 |

These are accessible **only inside Docker network**.

---

# 9. Access Points

* WordPress → https://ybassour.42.fr
* Admin Panel → https://ybassour.42.fr/wp-admin
* Adminer → https://ybassour.42.fr/adminer
* cAdvisor → https://ybassour.42.fr/cadvisor
* Static Site → https://ybassour.42.fr/static_site

---

# 10. First-Time Setup

## WordPress

1. Open main site
2. Create admin account
3. Login

## Adminer

* System: MariaDB
* Server: mariadb
* Credentials: from `.env` and `secrets/`

---

# 11. FTP Access

* Host: ybassour.42.fr
* Credentials: `.env` + secrets

Used to manage WordPress files.

---

# 12. Security

* HTTPS enabled (self-signed certificate)
* TLS 1.2 / 1.3 only
* Secrets externalized

---

# 13. Design Principles

* One service per container
* Stateless containers
* Persistent data via volumes only
* Nginx as single entry point
* Configuration via `.env` and secrets

---

# 14. Troubleshooting

## Common Issues

* Site not accessible → check `docker ps`
* Wrong service → check Nginx config
* DB errors → verify `.env` + MariaDB
* Missing data → volumes removed

---

# 15. Debugging Tools

## Inspect Containers

```
docker logs <container>
docker exec -it <container> sh
```

## Test Connectivity

```
docker exec -it nginx ping cadvisor
docker exec -it nginx wget http://cadvisor:8080
```

## Nginx

```
nginx -t
nginx -s reload
```

---

# 16. Volume Management

```
docker volume ls
docker volume inspect <name>
docker volume prune
```

---

# 17. Monitoring

cAdvisor provides:

* CPU usage
* Memory usage
* Network activity

---

# 18. Cleanup

* Full reset:

  ```
  make fclean
  ```

* Remove unused resources:

  ```
  docker system prune -a
  docker volume prune
  ```
