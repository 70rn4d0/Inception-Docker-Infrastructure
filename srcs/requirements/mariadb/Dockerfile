FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/init-db.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh

# Create the socket directory (Critical for MariaDB on Debian)
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

# Expose port 3306 for the network
EXPOSE 3306

# Start the script
ENTRYPOINT ["init-db.sh"]
