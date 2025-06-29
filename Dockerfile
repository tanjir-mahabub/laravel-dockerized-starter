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
    sed -i 's/DB_CONNECTION=mysql/DB_CONNECTION=sqlite/' .env && \
    sed -i 's/SESSION_DRIVER=database/SESSION_DRIVER=file/' .env && \
    sed -i 's/CACHE_STORE=database/CACHE_STORE=file/' .env && \
    sed -i 's/QUEUE_CONNECTION=database/QUEUE_CONNECTION=sync/' .env && \
    sed -i 's/APP_DEBUG=true/APP_DEBUG=false/' .env && \
    sed -i 's/APP_ENV=local/APP_ENV=production/' .env

# Generate application key
RUN php artisan key:generate --no-interaction

# Create SQLite database
RUN touch database/database.sqlite

# Run migrations
RUN php artisan migrate --force

# Set final permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage \
    && chmod -R 755 /var/www/bootstrap/cache

# Copy custom PHP configuration
COPY docker/php/local.ini /usr/local/etc/php/conf.d/local.ini

# Copy Nginx configuration
COPY docker/nginx/conf.d/app.conf /etc/nginx/sites-available/default

# Create startup script
RUN echo '#!/bin/bash\n\
php-fpm -D\n\
nginx -g "daemon off;"' > /start.sh && chmod +x /start.sh

# Expose port
EXPOSE 80

# Start services
CMD ["/start.sh"] 