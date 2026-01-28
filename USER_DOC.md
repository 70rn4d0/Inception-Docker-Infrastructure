# User Documentation

## 1. Services Provided
This infrastructure ("Inception") provides a complete, self-hosted WordPress website powered by three interconnected services:
* **NGINX**: A high-performance web server that handles secure HTTPS connections and acts as the entry point to the website.
* **WordPress**: The content management system (CMS) where you can build your website and manage content.
* **MariaDB**: The database server that securely stores all your website's data (posts, comments, users).

## 2. How to Start and Stop the Project
The project is controlled via a simple `Makefile` at the root of the directory.

* **Start the Project**:
    Open a terminal in the project folder and run:
    ```bash
    make
    ```
    *This will build the Docker images (if not already built) and start the containers in the background.*

* **Stop the Project**:
    To stop the services without deleting data, run:
    ```bash
    make down
    ```

* **Reset the Project**:
    To stop services and **delete all data** (database and website files), run:
    ```bash
    make fclean
    ```

## 3. Accessing the Website
Once the project is running (allow 1-2 minutes for the first launch):

* **Website URL**: Open your browser and go to `https://aech-chi.42.fr`.
    * *Note: You will see a "Potential Security Risk" warning because the SSL certificate is self-signed. You must accept this risk to proceed.*
* **Administration Panel**: Go to `https://aech-chi.42.fr/wp-admin`.
    * Log in using the administrator credentials.

## 4. Locating and Managing Credentials
For security reasons, passwords are **not** visible in the configuration files. They are stored in specific secret files located in the `secrets/` directory at the root of the project:

* `secrets/db_password.txt`: Database user password.
* `secrets/db_root_password.txt`: Database root password.
* `secrets/wp_admin_password.txt`: WordPress Administrator password.
* `secrets/wp_user_password.txt`: WordPress Standard User password.

To change a password, edit the corresponding text file and restart the project using `make re`.

## 5. Checking Service Status
To verify that the system is running correctly:
1.  Run the command: `docker ps`
2.  Ensure you see three containers listed: `nginx`, `wordpress`, and `mariadb`.
3.  The "STATUS" column should show "Up" for all three.
