# Developer Documentation

## 1. Environment Setup
To set up this environment from scratch on a new machine, follow these steps:

### Prerequisites
* **OS**: Linux (Debian/Ubuntu recommended) running inside a Virtual Machine.
* **Tools**: `docker` (Engine) and `docker-compose` (Plugin) must be installed.
* **Network**: Add the following line to `/etc/hosts`:
    ```text
    127.0.0.1 aech-chi.42.fr
    ```
* **Directories**: Ensure the host volume directories exist:
    ```bash
    mkdir -p /home/aech-chi/data/wordpress
    mkdir -p /home/aech-chi/data/mariadb
    ```

### Configuration Files
* **Environment Variables**: Create a `srcs/.env` file (see `srcs/.env.example` if available, or refer to the subject guide).
* **Secrets**: Create a `secrets/` directory at the root and populate it with the required password files (txt format, no newlines).

## 2. Building and Launching
The project automation is handled by the `Makefile`.
* **Build & Run**: `make` executes `docker compose -f srcs/docker-compose.yml up -d --build`.
* **Rebuild**: `make re` performs a full clean and rebuilds all images from scratch.

## 3. Container Management Commands
You can manage the stack using standard Docker commands:

* **View Logs**: To see real-time logs from all services:
    ```bash
    docker compose -f srcs/docker-compose.yml logs -f
    ```
* **Access a Container**: To open a shell inside a running container (e.g., WordPress):
    ```bash
    docker exec -it wordpress /bin/bash
    ```
* **Restart a Specific Service**:
    ```bash
    docker compose -f srcs/docker-compose.yml restart nginx
    ```

## 4. Data Storage and Persistence
This project uses **Docker Bind Mounts** to ensure data persists even if containers are destroyed.

* **Database Data**:
    * **Host Path**: `/home/aech-chi/data/mariadb`
    * **Container Path**: `/var/lib/mysql`
    * *Mechanism*: The MariaDB container writes its data files directly to the host folder.

* **WordPress Files**:
    * **Host Path**: `/home/aech-chi/data/wordpress`
    * **Container Path**: `/var/www/wordpress`
    * *Mechanism*: The WordPress container installs core files here. NGINX mounts this same volume (Read-Only) to serve static assets.

**Caution**: Running `make fclean` executes `rm -rf` on these host directories, permanently deleting all data.
