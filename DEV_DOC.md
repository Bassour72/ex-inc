# 🛠️ Developer Documentation
This project is part of the 42 curriculum. It explains how to set up, build, and manage the Inception infrastructure using Docker and Docker Compose.

---
### Project Structure

- `docker-compose.yml` → Defines all services, networks, and volumes  
- `Makefile` → Automates build, run, stop, and cleanup  
- `.env` → Stores environment variables and secrets  

---

### Core Services

- `nginx/` → Reverse proxy  
  - Handles HTTPS (TLS)  
  - Routes traffic to internal services  

- `wordpress/` → WordPress application  
  - Runs with PHP-FPM  
  - Connects to MariaDB for data storage  

- `mariadb/` → Database server  
  - Stores WordPress data  
  - Uses persistent volumes  

---

### Bonus Services

- `redis/` → In-memory cache  
  - Improves WordPress performance  
  - Reduces database load  

- `ftp/` → File transfer service  
  - Allows uploading files to WordPress  
  - Uses authentication and isolated access  

- `adminer/` → Database management tool  
  - Web interface to manage MariaDB  
  - Useful for debugging and inspection  

- `cadvisor/` → Container monitoring  
  - Tracks CPU, memory, and network usage  
  - Provides real-time container metrics  

- `static-site/` → Simple web service  
  - Serves static content (HTML/CSS)  
  - Used for testing or additional service exposure  

---


### Key Concepts

- Services communicate via **Docker network using service names**  
- Data is stored in **volumes**, not inside containers  
- Containers are **ephemeral** (they can be destroyed and recreated)  
- Configuration is centralized using `.env`  

---


###  Prerequisites

Make sure the following tools are installed:

Required tools:

- Docker Engine
- Docker Compose v2+
- Make
- Git
- sudo privileges

### Verify installation:

```bash
docker --version
docker compose version
make --version
```

---

### . Initial Setup

Before running the project:

### Clone repository

```bash
git clone <repository_url> inception
cd inception
``` 
### Create environment file

```bash
cp .env.example .env
```

The `.env` file contains:

- Database credentials
- WordPress configuration
- Domain name
### Secrets

Sensitive data is stored in:

```
/secrets/
```

Examples:

- db_password.txt
- wp_admin_password.txt

Secrets are injected at runtime and are never included in Docker images.

---
### directories exist
3. Ensure required directories exist:
   - Volumes (e.g. `/home/${USER}/data/` if using bind mounts)  

---

### 3. Project Structure

- `docker-compose.yml` → Defines services and network  
- `Makefile` → Automates project commands  
- `.env` → Environment variables  
- `nginx/` → Reverse proxy configuration  
- `wordpress/` → WordPress files  
- `mariadb/` → Database configuration  
- `requirements/` → Dockerfiles and configs  

├── DEV_DOC.md
├── Makefile
├── README.md
├── secrets
│   ├── credentials.txt
│   ├── db_password.txt
│   ├── db_root_password.txt
│   ├── ftp_user_password.txt
│   ├── wp_admin_password.txt
│   └── wp_user_password.txt
├── srcs
│   ├── docker-compose.yml
│   └── requirements
│       ├── bonus
│       │   ├── Adminer
│       │   │   ├── conf
│       │   │   │   └── www.conf
│       │   │   └── Dockerfile
│       │   ├── cAdvisor
│       │   │   ├── Dockerfile
│       │   │   └── tools
│       │   │       └── entrypoint.sh
│       │   ├── ftp
│       │   │   ├── conf
│       │   │   │   └── vsftpd.conf
│       │   │   ├── Dockerfile
│       │   │   └── tools
│       │   │       └── init.sh
│       │   ├── redis
│       │   │   ├── Dockerfile
│       │   │   └── tools
│       │   │       └── init.sh
│       │   └── static_site
│       │       ├── conf
│       │       │   └── nginx.conf
│       │       ├── Dockerfile
│       │       └── tools
│       │           └── Static_site
│       │               ├── images
│       │               │   ├── about.png
│       │               │   ├── background.png
│       │               │   ├── contact.png
│       │               │   ├── course.png
│       │               │   ├── facebook.png
│       │               │   ├── instagram.png
│       │               │   ├── linkedin.png
│       │               │   ├── logo.png
│       │               │   ├── menu.png
│       │               │   ├── offer.png
│       │               │   ├── pic-1.png
│       │               │   ├── pic-2.png
│       │               │   ├── pic-3.png
│       │               │   ├── search.html
│       │               │   ├── Thumbs.db
│       │               │   └── twitter.png
│       │               ├── index.html
│       │               ├── style.css
│       │               └── test-image.jpg
│       ├── mariadb
│       │   ├── Dockerfile
│       │   └── tools
│       │       └── init.sh
│       ├── nginx
│       │   ├── conf
│       │   │   └── nginx.conf
│       │   ├── Dockerfile
│       │   └── tools
│       │       └── init.sh
│       └── wordpress
│           ├── conf
│           │   ├── uploads.ini
│           │   └── www.conf
│           ├── Dockerfile
│           └── tools
│               └── init.sh
└── USER_DOC.md

---

### . Build & Run the Project

```bash
make
```

### Using Docker Compose

```bash
docker compose up -d --build
```

This will:

- Build Docker images
- Create network and volumes
- Start all containers

---

###  Restart the Project

- `make re`

This will:

- Rebuild all images  
- Restart all containers  

---


###  Using Docker Compose

- ` docker compose down -v`

This will:

- Rebuild all images  
- Restart all containers  

---

### 6. Stop the Project

- `make down`

This will:

- Stop all containers  
- Remove containers and network  
- Keep volumes (data is preserved)  

---
### 6. Using Docker Compose

- `docker compose down`

This will:

- Stop all containers  
- Remove containers and network  
- Keep volumes (data is preserved)  

---
### . Stop & Remove the Project

Remove everything (containers, images, volumes):

- `make fclean`

This will:

- Stop and remove all containers  
- Remove Docker images  
- Remove volumes  

⚠️ This will permanently delete:

- WordPress data  
- MariaDB database  

---
### . Using Docker Compose

Remove everything (containers, images, volumes):

- `docker compose -f srcs/docker-compose.yml down --rmi all -v`

This will:

- Stop and remove all containers  
- Remove Docker images  
- Remove volumes  

⚠️ This will permanently delete:

- WordPress data  
- MariaDB database  

---
#  Data Storage & Persistence

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

#  Access URLs (User Services)

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
###  Common Debugging Workflow

1. Check containers:
   - `docker ps`

2. Check logs:
   - `docker logs <container>`

3. Test connectivity:
   - `wget http://service:port`

4. Check Nginx:
   - `nginx -t`

5. Check environment:
   - `env`
6. Check ftp
  - curl ftp://localhost --user  (from `.env`):(from `secrets/ftp_user_password.txt`)
  - echo "test file" > hello.txt
  - curl -T hello.txt ftp://localhost --user  (from `.env`):(from `secrets/ftp_user_password.txt`)
  - wget -m -nH -P wp-admin --ftp-user=(from `.env`) --ftp-password=(from `secrets/ftp_user_password.txt`) ftp://`ftp container ip address`/wp-admin
  - curl -u  (from `.env`):(from `secrets/ftp_user_password.txt`) ftp://localhost/Makefile -o MyNewFile 

7. Check tls
# TLS 1.2
  - curl -vk --tls-max 1.2 https://localhost
  - curl -vk --tlsv1.2 https://localhost

  # TLS 1.3
  - curl -vk --tls-max 1.3 https://localhost
  - curl -vk --tlsv1.3 https://localhost

  # TLS 1.0 (should fail)
  - curl -vk --tls-max 1.0 https://localhost
  - curl -vk --tlsv1.0 https://localhost
---

### 19. Cleanup Commands

- `make fclean` → Full reset  
- `docker system prune -a` → Remove unused resources  
- `docker volume prune` → Remove unused volumes  

---

###  Container Management Commands

- `docker ps` → Running containers  
- `docker ps -a` → All containers  
- `docker logs <container>` → View logs  
- `docker exec -it <container> sh` → Access container shell  

---

###  Networking & Connectivity

Containers communicate using **service names (DNS)**:

- Example: `mariadb:3306`, `cadvisor:8080`

---

Test connectivity:

- `docker exec -it nginx ping cadvisor`  
- `docker exec -it nginx wget -qO- http://cadvisor:8080`

---

Notes:

- Commands must run inside a container  
- Host machine cannot access internal service names  
- If HTTP works but ping fails → normal  

---

###  Volume Management

- `docker volume ls` → List volumes  
- `docker volume inspect <name>` → Inspect volume  
- `docker volume prune` → Remove unused volumes  

---

###  Environment Variables

- `docker exec -it <container> env`  
- `docker inspect <container>`  

Used for:

- Debugging configuration  
- Verifying `.env` values  

---

###  Nginx Debugging

- `docker exec -it nginx nginx -t` → Test config  
- `docker exec -it nginx nginx -s reload` → Reload service  

---

###  TLS Version Testing

Test supported TLS versions:

---

TLS 1.0 (should FAIL ❌):

- `docker exec -it nginx openssl s_client -connect localhost:443 -tls1`

---

TLS 1.1 (should FAIL ❌):

- `docker exec -it nginx openssl s_client -connect localhost:443 -tls1_1`

---

TLS 1.2 (should SUCCESS ✅):

- `docker exec -it nginx openssl s_client -connect localhost:443 -tls1_2`

---

TLS 1.3 (should SUCCESS ✅):

- `docker exec -it nginx openssl s_client -connect localhost:443 -tls1_3`

---
