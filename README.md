*This project has been created as part of the 42 curriculum by aech-chi.*

## Description
This project, "Inception," aims to broaden knowledge of system administration by using Docker. It involves setting up a complete infrastructure composed of different services (NGINX, WordPress, MariaDB) under specific rules using Docker Compose.

Each service runs in a dedicated container, built from Alpine or Debian, ensuring a modular and secure architecture.

## Instructions
1. **Prerequisites**: Ensure `docker` and `docker-compose` are installed.
2. **Setup Domain**: Add `127.0.0.1 aech-chi.42.fr` to your `/etc/hosts` file.
3. **Data Folders**: Ensure `/home/aech-chi/data/wordpress` and `/home/aech-chi/data/mariadb` exist.
4. **Secrets**: Populate the files in `secrets/` with your passwords.
5. **Launch**: Run `make` at the root of the directory.
6. **Access**: Open `https://aech-chi.42.fr` in your browser.

## Technical Comparisons

### Virtual Machines vs Docker
* **Virtual Machines (VMs)**: Virtualize the hardware. Each VM has a full OS kernel, making them heavy and slow to start. They provide strong isolation but consume significant resources.
* **Docker**: Virtualizes the OS. Containers share the host's kernel but isolate processes. They are lightweight, start instantly, and are ideal for microservices.

### Secrets vs Environment Variables
* **Environment Variables**: Stored in plain text in the system environment. Can be seen via `docker inspect` or `printenv`. Less secure for sensitive data.
* **Docker Secrets**: Manage sensitive data (passwords, keys). The data is mounted as a file inside the container only when needed and is not exposed in the environment variables. This is the recommended secure method.

### Docker Network vs Host Network
* **Host Network**: The container shares the host's IP and port space. No isolation.
* **Docker Network**: Creates an isolated virtual network (bridge). Containers can talk to each other by name (DNS) without exposing ports to the outside world, increasing security.

### Docker Volumes vs Bind Mounts
* **Docker Volumes**: Managed by Docker in a specific storage area. Harder to access directly from the host but easier to back up.
* **Bind Mounts**: A specific file or directory on the host machine is mounted into a container. We use this to store data in `/home/aech-chi/data` so it persists and is accessible by the host user.

## Resources
The following documentation was used to configure the services and orchestration:

* **Docker Engine & Compose**:
    * [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
    * [Compose File Version 3 Reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)
    * [Docker Networking Guide](https://docs.docker.com/network/)

* **NGINX**:
    * [NGINX Beginner’s Guide](https://nginx.org/en/docs/beginners_guide.html)
    * [Configuring HTTPS Servers](https://nginx.org/en/docs/http/configuring_https_servers.html)

* **WordPress & CLI**:
    * [WP-CLI Command Reference](https://developer.wordpress.org/cli/commands/)
    * [WordPress Docker Official Images](https://hub.docker.com/_/wordpress) (Used for reference on volume paths)

* **MariaDB**:
    * [MariaDB Knowledge Base: Installing and Using MariaDB via Docker](https://mariadb.com/kb/en/installing-and-using-mariadb-via-docker/)
