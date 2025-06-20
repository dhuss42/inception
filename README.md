# Inception

Inception is a system administration project aimed at building a containerized web hosting environment using Docker and Docker Compose. The goal is to set up and configure multiple services—such as NGINX with SSL, WordPress with php-fpm, and MariaDB—each running in isolated containers. Within the bonus part multiple services, each running inside their own container, are added. These include Redis, FTP, Adminer, a static website and a service of our choice, for which I chose portainer.

## Contents

1. [Project Overview](#1-Project-overview)
2. [Mandatory Part](#2.-Mandatory-part)
3. [Bonus](#3.-Bonus)

## 2. Mandatory part

### Container vs Virtual Machine

Both Docker and Virtual Machines (VMs) are virtualization tools, but they differ in how they virtualize

| Feature | Docker | VirtualMachine |
|----------|----------|----------|
| Layer | Virtualizes the application layer | Virtualises the entire OS |
| Kernel | Shares the host's kernel | Has its own kernel |
| Size | Leightweight | Heavy (full OS) |
| Startup Speed | starts in seconds | starts in minutes |
| Portability | OS mus be compatiable with the host's kernel | Can run any OS on any kernel |

### Docker
Docker is a platform that allows you to build, run, and manage containers. Containers package up an application with everything it needs to run—code, libraries, dependencies, etc.—into a single unit that can run consistently across environments.

### Docker Compose
Docker Compose is a tool for defining and managing multi-container Docker applications using a YAML file (docker-compose.yml). Instead of running each container manually with complex docker run commands, you can describe the entire stack—services, networks, volumes, environment variables, and dependencies—in a single file. Then, you use docker-compose up to build and start all the containers.

### Docker Networks
When you define services in the same docker-compose.yml and network, they can communicate using just container names. You don’t need to expose ports between services.

### NGINX
NGINX, a high-performance web server and reverse proxy. It acts as the sole entry point into the system, handling all incoming HTTPS traffic. As required by the project, it must support only TLSv1.2 or TLSv1.3, ensuring encrypted and secure communication between the client and the server. NGINX does not process PHP code itself; instead, it forwards requests to the WordPress container using FastCGI. To serve static WordPress files, it shares a volume with the WordPress container.

### WordPress
WordPress is an open-source content management system (CMS) that allows users to create, manage, and publish websites or blogs through a user-friendly interface, primarily using PHP and a MySQL-compatible database. The WordPress container runs with php-fpm (FastCGI Process Manager), which handles the execution of PHP code. WordPress is installed and fully configured through the use of a script.

### MariaDB
The backend of the system is powered by MariaDB, a robust Database Management System (DBMS). It stores and manages all WordPress data, including users, posts, settings, and metadata. The MariaDB container also uses a persistent volume to ensure that the database content is not lost when containers are restarted or rebuilt. It communicates with the WordPress container over a custom Docker network

## 3. Bonus
In the bonus part of the project, additional services are introduced, each running in its own dedicated container.

An FTP server is set up to point directly to the WordPress website volume, allowing easy file transfers and management of website content.

Adminer is included as a lightweight database management tool, providing a simple web interface to manage the MariaDB database without needing complex setups.

A Redis cache is implemented to improve WordPress performance. Redis is a fast, in-memory, key-value store that acts as a caching layer between the webserver and the database. By storing frequently accessed data in RAM, Redis significantly reduces response times by serving cached data quickly instead of querying the database every time. However, caching can introduce stale data, so a time-to-live (TTL) is set to ensure the cache stays reasonably fresh.

Additionally, a simple static website is created using HTML and CSS, serving as a basic showcase or informational page separate from the WordPress application.

Finally, Portainer, a service chosen to facilitate container management, is included. Portainer offers an easy-to-use graphical interface to monitor and control Docker containers, networks, and volumes, helping streamline the administration of the entire Docker-based stack.


