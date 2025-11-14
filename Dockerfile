FROM wordpress:php8.2-apache

# Increase memory limit (optional)
RUN echo "memory_limit=512M" > /usr/local/etc/php/conf.d/memory.ini
RUN a2enmod rewrite

EXPOSE 80
