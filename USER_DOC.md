# User Documentation: Inception Project

This document provides the necessary information for an administrator or end-user to interact with the **Inception** infrastructure.

---

## 1. Provided Services
The infrastructure consists of three core services working together:
*   **NGINX**: The only entry point to the system, serving as a web server and reverse proxy via port 443.
*   **WordPress**: The Content Management System (CMS) that powers the website, running on PHP-FPM.
*   **MariaDB**: The relational database management system that stores all website content and user data.

## 2. Managing the Project

### Starting the Services
To launch the entire stack, navigate to the root of the project and run:
```bash
make

### Stopping the Services

To stop the services without deleting the persistent data, run:
```bash
make stop

To stop and remove containers, networks, and internal Docker volumes, run:
```bash
make clean

## 3. Accessing the Website

Once the containers are running, you can access the services using a web browser:

Main Website: Open https://rpedrosa.42.fr.

WordPress Admin Dashboard: Open https://rpedrosa.42.fr/wp-admin.

Note: You must have rpedrosa.42.fr mapped to 127.0.0.1 in your local /etc/hosts file for these links to work.

## 4. Managing Credentials

Security is a priority for this project. Credentials are managed as follows:

Location: All passwords and sensitive keys are stored in the srcs/secrets/ directory.

Environment Variables: General settings (non-sensitive) are located in the srcs/.env file.

Database Admin: The MariaDB root password and user credentials are encrypted via Docker Secrets during runtime.

## 5. Health Check

To verify that all services are running correctly, use the following command:

```bash
docker ps

A healthy stack should show three containers (nginx, wordpress, mariadb) with a status of Up.

You can also check the logs for specific errors:

```bash
docker logs <container_name>