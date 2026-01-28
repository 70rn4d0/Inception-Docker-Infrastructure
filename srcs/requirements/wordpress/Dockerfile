FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-zip \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' \
    /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/setup-wp.sh /usr/local/bin/setup-wp.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp


WORKDIR /var/www/html/

RUN chmod +x /usr/local/bin/setup-wp.sh

RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["setup-wp.sh"]
