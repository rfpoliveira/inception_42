# Inception - 42 Curriculum

*This project has been created as part of the 42 curriculum by **rpedrosa**.*

---

## 📝 Description
The **Inception** project aims to broaden knowledge of system administration by using **Docker**. It involves virtualizing several Docker images in a personal virtual machine, creating a small, secure infrastructure composed of different services:

*   **NGINX**: With TLS v1.2/1.3 support.
*   **WordPress**: Running with `php-fpm`.
*   **MariaDB**: The database engine.

Every service runs in its own dedicated container, communicating over a private Docker network with persistent data stored in named volumes.

---

## 🛠️ Instructions

### Prerequisites
*   A Virtual Machine with **Docker** and **Docker Compose** installed.
*   Manual creation of data directories on the host:
    *   `/home/rpedrosa/data/mariadb`
    *   `/home/rpedrosa/data/wordpress`

### Execution
All configuration files are located in the `srcs` folder. Use the **Makefile** at the root of the directory to manage the application:
```bash
# To build the Docker images and start the containers
make

# To stop the services
make down

# To remove containers, networks, and volumes (Docker-side)
make clean

# To perform a full cleanup (including host data and system prune)
make fclean

# To restart the entire project
make re

```

---

## 🌐 Access & Domain
Once the infrastructure is running, the website is accessible via:
*   **URL**: [https://rpedrosa.42.fr](https://rpedrosa.42.fr)
*   **Note**: Ensure your `/etc/hosts` file is configured to map `rpedrosa.42.fr` to your VM's IP address to allow local domain resolution.

## 📚 Resources
*   [Official Docker Documentation](https://docs.docker.com/)
*   [WordPress CLI (WP-CLI) Handbook](https://make.wordpress.org/cli/handbook/)
*   [NGINX SSL/TLS Configuration Guide](https://nginx.org/en/docs/http/configuring_https_servers.html)

### AI Usage
As per the project guidelines, AI tools were only used for research and finding good material to work from.

---

## 🏛️ Project Design Choices

### Virtual Machines vs Docker
*   **Virtual Machines**: Virtualize hardware to run a full Guest OS, resulting in high resource consumption and slow boot times.
*   **Docker**: Uses containerization to share the host's kernel, making it lightweight, fast, and highly portable.

### Secrets vs Environment Variables
*   **Environment Variables (.env)**: Best for non-sensitive configuration (e.g., database names, domain names).
*   **Secrets**: Secure way to manage sensitive data like passwords. They are mounted into the container as files rather than exposed as environment variables, reducing the risk of accidental exposure.

### Docker Network vs Host Network
*   **Docker Network (Bridge)**: Creates an isolated virtual network where containers communicate via service names (DNS), providing high security.
*   **Host Network**: Removes isolation by making the container use the host's networking stack directly, which is less secure and bypasses Docker’s port mapping.

### Docker Volumes vs Bind Mounts
*   **Docker Volumes (Named)**: Managed by Docker and preferred for data persistence. They are decoupled from the host's file structure while still allowing data to survive container removal.
*   **Bind Mounts**: Rely on a specific directory structure on the host. While banned for mandatory volumes in this project, they are often used in development for real-time code syncing.

---

> **Note**: For more detailed information, please refer to `USER_DOC.md` and `DEV_DOC.md` located in the root directory.