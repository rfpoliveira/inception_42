# Developer Documentation: Inception Project

This document is intended for developers who wish to set up, maintain, or modify the **Inception** infrastructure.

---

## 1. Development Environment Setup

### Prerequisites
Before starting, ensure your development environment (Virtual Machine) has the following installed
*   **Docker**: Engine version 20.10+ recommended.
*   **Docker Compose**: V2 installed as a plugin.
*   **Make**: Standard build automation tool.
*   **Git**: For version control.

### Configuration Files
You must manually prepare the following files (which are excluded from the repository for security)
*   **`.env`**: Located in `./srcs/`. Contains non-sensitive variables like `DOMAIN_NAME`, `DB_NAME`, and SSL metadata.
*   **`secrets/`**: Located in `./srcs/secrets/`. Must contain `.txt` files for `db_password.txt`, `db_root_password.txt`, and `wp_admin_password.txt`.

---

## 2. Build and Launch Process

The project uses a **Makefile** to streamline the Docker Compose workflow

### Compilation Commands
*   **Build & Run**: `make` or `make up`
    *   Creates host directories: `/home/$(USER)/data/mariadb` and `/home/$(USER)/data/wordpress`
    *   Configures `/etc/hosts` for local domain resolution
    *   Triggers `docker compose up --build`.
*   **Stop**: `make down`
*   **Full Reset**: `make re` (Triggers `fclean` followed by `all`).

---

## 3. Container Architecture

The stack is composed of three custom-built containers

| Service | Base Image | Purpose |
| :--- | :--- | :--- |
| **NGINX** | Debian Bullseye | Handles TLS v1.2/1.3 and proxies PHP requests |
| **WordPress** | Debian Bullseye | Runs PHP-FPM 7.4 and WP-CLI for automation |
| **MariaDB** | Debian Bullseye | Stores relational data and handles user authentication |

### Networking
*   **Network Name**: `inception_network` (Bridge)
*   **Isolation**: Only the NGINX container exposes a port (443) to the host. MariaDB (3306) and WordPress (9000) are only accessible within the internal bridge network

---

## 4. Data Persistence & Storage

As per project requirements, we use **Docker Named Volumes** mapped to specific host paths

*   **Database Storage**: Mapped to `/home/rpedrosa/data/mariadb`. Stores the MariaDB raw data files
*   **Website Files**: Mapped to `/home/rpedrosa/data/wordpress`. Stores the WordPress core files, themes, and uploads

### Managing Persistence
To wipe the containers but keep the data, use `make clean`. To completely delete the data on the host machine (for a fresh install), use `make fclean`

---

## 5. Deployment Checklist
1. Ensure the `srcs/` directory contains your `docker-compose.yml` and `.env`
2. Verify that each service has its own `Dockerfile` in `srcs/requirements/`
3. Check that no passwords or credentials are hardcoded in the Dockerfiles
4. Run `make` and verify connectivity via `https://rpedrosa.42.fr`
