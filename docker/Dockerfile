# =========================
# Stage 1: Builder
# =========================
FROM wordpress:6.8-php8.2-apache AS builder

# Bật mod_rewrite để dev/test cho giống runtime
RUN a2enmod rewrite

# Copy themes & plugins từ repo vào /build
# Thư mục của bạn: wordpress/wp-content/{themes,plugins}
COPY wordpress/wp-content/themes/ /build/wp-content/themes/
COPY wordpress/wp-content/plugins/ /build/wp-content/plugins/

# Dọn rác dev: .git, editor settings, zip, log…
RUN find /build -name ".git" -o -name ".vscode" -o -name ".idea" -o -name "*.zip" -o -name "*.log" -o -name "*.DS_Store" -exec rm -rf {} + \
    && find /build -type d -exec chmod 755 {} \; \
    && find /build -type f -exec chmod 644 {} \;


# =========================
# Stage 2: Runtime (nhẹ hơn)
# =========================
FROM wordpress:6.8-php8.2-apache

# PHP & Apache config runtime
RUN a2enmod rewrite \
    && echo "memory_limit=512M" > /usr/local/etc/php/conf.d/memory.ini

# Copy themes & plugins đã được chuẩn hóa từ builder
COPY --from=builder /build/wp-content/themes/ /var/www/html/wp-content/themes/
COPY --from=builder /build/wp-content/plugins/ /var/www/html/wp-content/plugins/

# Quyền file/folder chuẩn cho WordPress
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

EXPOSE 80
