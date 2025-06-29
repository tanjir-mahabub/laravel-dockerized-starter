# Use PHP 8.4 with FPM
FROM php:8.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nginx \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy application files
COPY src/ .

# Create necessary directories and set permissions
RUN mkdir -p /var/www/bootstrap/cache \
    && mkdir -p /var/www/storage/logs \
    && mkdir -p /var/www/storage/framework/cache \
    && mkdir -p /var/www/storage/framework/sessions \
    && mkdir -p /var/www/storage/framework/views \
    && chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage \
    && chmod -R 755 /var/www/bootstrap/cache

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Create production .env file
RUN cp .env.example .env && \
    sed -i 's/APP_ENV=local/APP_ENV=production/' .env && \
    sed -i 's/APP_DEBUG=true/APP_DEBUG=false/' .env

# Generate application key
RUN php artisan key:generate --no-interaction

# Set final permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage \
    && chmod -R 755 /var/www/bootstrap/cache

# Copy custom PHP configuration
COPY docker/php/local.ini /usr/local/etc/php/conf.d/local.ini

# Copy Nginx configuration
COPY docker/nginx/conf.d/app.conf /etc/nginx/sites-available/default

# Create startup script that sets environment variables
RUN echo '#!/bin/bash\n\
# Update .env file with environment variables\n\
if [ ! -z "$DB_HOST" ]; then\n\
    sed -i "s/DB_HOST=.*/DB_HOST=$DB_HOST/" /var/www/.env\n\
fi\n\
if [ ! -z "$DB_DATABASE" ]; then\n\
    sed -i "s/DB_DATABASE=.*/DB_DATABASE=$DB_DATABASE/" /var/www/.env\n\
fi\n\
if [ ! -z "$DB_USERNAME" ]; then\n\
    sed -i "s/DB_USERNAME=.*/DB_USERNAME=$DB_USERNAME/" /var/www/.env\n\
fi\n\
if [ ! -z "$DB_PASSWORD" ]; then\n\
    sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=$DB_PASSWORD/" /var/www/.env\n\
fi\n\
# Debug: show the processed .env file\n\
echo "=== Database configuration ==="\n\
grep "DB_" /var/www/.env\n\
echo "============================="\n\
php-fpm -D\n\
nginx -g "daemon off;"' > /start.sh && chmod +x /start.sh

# Expose port
EXPOSE 80

# Start services
CMD ["/start.sh"] 