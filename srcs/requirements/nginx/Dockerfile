FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MO/ST=BG/L=BG/O=42/OU=42/CN=aech-chi.42.fr/UID=aech-chi"

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN chmod 755 /var/www/html/

RUN chown -R www-data:www-data /var/www/html/

CMD ["nginx", "-g", "daemon off;"]
