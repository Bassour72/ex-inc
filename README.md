*This project has been created as part of the 42 curriculum by **[ybassour]**.*

## 📝 Description

Inception is a system administration project focused on building a secure, multi-container infrastructure using Docker and Docker Compose.

The main objective is to deploy a complete web environment composed of multiple isolated services, including:
- Nginx (reverse proxy with TLS)
- WordPress (application)
- MariaDB (database)
- Redis (cache)
- FTP, Adminer, Static Site, and cAdvisor (bonus services)

Each service runs inside its own container, ensuring isolation, portability, and reproducibility across environments.

### 🐳 Use of Docker

Docker is used to:
- Build custom images using Dockerfiles (no pre-built images allowed)
- Run services in isolated containers
- Manage communication via a private bridge network
- Persist data using Docker volumes
- Orchestrate the entire infrastructure using Docker Compose

This approach eliminates environment inconsistencies and ensures the project runs identically on any machine.

### 🏗️ Design Choices

- **Reverse Proxy (Nginx):** Acts as a single entry point and handles TLS (HTTPS)
- **Private Network:** Services communicate internally using Docker DNS (service names)
- **Volumes:** Ensure data persistence for WordPress and MariaDB
- **TLS (HTTPS):** Secures all external communication
- **Separation of Services:** Each component runs in its own container for modularity and scalability


## 🚀 Instructions

### 📋 Prerequisites

Before starting, ensure your environment is correctly set up:

- Docker
- Docker Compose
- Make (recommended for automation)
- Sudo privileges (required on most systems)

Verify installation:

- `docker --version`
- `docker compose version`
- `make --version`

---

### 🖥️ Host Configuration

Map your domain to localhost:

```bash
echo "127.0.0.1 ybassour.42.fr" | sudo tee -a /etc/hosts
```

Make sure no other services (Apache, Nginx, etc.) are using ports **80** or **443**.

---

### 🛠️ Step-by-Step Setup

#### 1. Clone the Repository

```bash
git clone <repository_url> inception
cd inception
```

---

#### 2. Configure Environment

Create your `.env` file:

```bash
cp .env.example .env
```

Edit it with your credentials:

- Database user/password  
- WordPress admin credentials  
- Domain name  
- FTP credentials  

---

#### 3. Build & Launch the Infrastructure

Using **Make (recommended):**

```bash
make
```

Or directly with Docker:

```bash
docker compose up -d --build
```

This will:

- Build all Docker images from scratch  
- Create the Docker network  
- Initialize volumes (persistent storage)  
- Start all containers in detached mode  

---

### 🌐 Accessing the Services

Once containers are running, access services via your browser:

| Service            | URL                                      |
|--------------------|------------------------------------------|
| Main Website       | https://ybassour.42.fr                   |
| WordPress Admin    | https://ybassour.42.fr/wp-admin/         |
| Adminer            | https://ybassour.42.fr/adminer           |
| Static Site        | https://ybassour.42.fr/static_site       |
| cAdvisor           | https://ybassour.42.fr/cadvisor          |

**Notes:**

- All traffic goes through **Nginx (reverse proxy)** on port **443**  
- Internal services are **not exposed directly**  
- Routing is handled via Nginx configuration  

---

### 🔧 Docker Concepts in Practice

This project demonstrates key Docker concepts:

- **Bridge Network:** Containers communicate using service names (DNS)  
- **Volumes:** Data persists outside containers  
- **Isolation:** Each service runs in its own container  
- **Reverse Proxy:** Nginx routes traffic securely using TLS  

Example internal communication:

- `mariadb:3306`  
- `wordpress:9000`  
- `cadvisor:8080`  

---

### 🧹 Maintenance & Shutdown

Stop containers (keep data):

```bash
docker compose stop
```

or:

```bash
make down
```

---

Stop and remove containers (keep volumes):

```bash
docker compose down
```

---

Full cleanup (⚠️ deletes all data):

```bash
docker compose down -v
```

or:

```bash
make fclean
```

---

Optional deep cleanup:

```bash
docker system prune -a --volumes
```

---

### 🔍 Debugging & Monitoring

View logs:

```bash
docker compose logs -f
```

Check running containers:

```bash
docker compose ps
```

Access a container shell:

```bash
docker exec -it <container_name> sh
```

Test internal connectivity:

```bash
docker exec -it nginx ping wordpress
docker exec -it nginx wget -qO- http://cadvisor:8080
```

Check Nginx configuration:

```bash
docker exec -it nginx nginx -t
```

---

### 📊 Monitoring

Access container metrics:

- **cAdvisor → https://ybassour.42.fr/cadvisor**

Provides:

- CPU usage  
- Memory usage  
- Network activity  

---

### 💡 Troubleshooting

Common issues and causes:

**Site not loading**  
→ Check Nginx logs  

**Database connection error**  
→ Verify `.env` credentials and MariaDB container  

**Service unreachable**  
→ Ensure containers are in the same Docker network  

**Permission issues**  
→ Check volume ownership and container user  

---

### ⚠️ Notes

- Containers communicate using **service names**, not IPs  
- Data is stored in **Docker volumes**, not containers  
- TLS is handled by **Nginx (port 443)**  
- Self-signed certificates may trigger browser warnings (this is normal)  

---


## 📚 Resources

### 📖 Official Documentation

- Docker Documentation: https://docs.docker.com  
- Docker Compose Documentation: https://docs.docker.com/compose/  
- Nginx Documentation: https://nginx.org/en/docs/  
- MariaDB Documentation: https://mariadb.org/documentation/  
- OpenSSL Documentation: https://www.openssl.org/docs/  

---

### 📘 Learning Resources

- Nigel Poulton, *Docker Deep Dive: Zero to Docker in a Single Book*  
- SQL Introduction (W3Schools): https://www.w3schools.com/sql/  

---

### 🎥 Video Tutorials

- Docker Deep Dive Course — Nigel Poulton (YouTube)  
  https://www.youtube.com/watch?v=WDMZK5DeGSA
  https://www.youtube.com/watch?v=PrusdhS2lmo&t=21937s

- TLS / SSL Explained — (YouTube)  
  https://www.youtube.com/playlist?list=PLdTZTP1X_y5p0_9mwIWDdFxlF5N_Q_iWj
  https://www.youtube.com/watch?v=ZkL10eoG1PY&t=1045s

- How HTTPS Works — Practical Networking (YouTube)  
  https://www.youtube.com/watch?v=EnY6fSng3Ew

> These resources were used for conceptual understanding of Docker architecture, TLS, and networking principles.

---

### 🤖 AI Usage Disclosure

AI tools (ChatGPT / Claude) were used in this project for:

- **Conceptual explanations**  
  Understanding Docker architecture, networking, TLS, and FastCGI vs HTTP  

- **Debugging assistance**  
  Troubleshooting issues related to Alpine Linux packages, PHP-FPM configuration, and WP-CLI setup  

- **Documentation structuring**  
  Improving clarity, organization, and formatting of the README and technical documentation  

AI was not used to generate core project logic or configuration blindly.  
All configurations and implementations were reviewed, tested, and validated manually.

# 🏗️ Design Choices & Comparisons

This project required several architectural decisions. Below are the main choices and the reasoning behind them.

---

## 🖥️ Virtual Machines vs Docker

- Virtual Machines run a full OS → heavy and slow  
- Docker containers share the host kernel → lightweight and fast  

✔ Choice: Docker  
Reason: Faster startup, lower resource usage, and easier service isolation.

---

## 🔐 Secrets vs Environment Variables

- Environment variables are easy to use but exposed in container configuration  
- Secrets are more secure and not stored in image layers  

✔ Choice: Secrets for sensitive data (passwords), `.env` for configuration  
Reason: Prevent leaking credentials while keeping flexibility.

---

## 🌐 Docker Network vs Host Network

- Host network exposes services directly to the host  
- Docker bridge network isolates containers in a private network  

✔ Choice: Bridge network  
Reason: Better security and controlled communication using service names (DNS).

---

## 💾 Docker Volumes vs Bind Mounts

- Volumes are managed by Docker → reliable and portable  
- Bind mounts depend on host paths → less portable  

✔ Choice: Volumes (with optional bind mount for development)  
Reason: Ensure persistent and stable storage for MariaDB and WordPress data.

---