#!/bin/bash

# Laravel Installation Script for Dockerized Starter Environment
# This script installs Laravel 12 in the Docker container

set -e

echo "🚀 Starting Laravel 12 installation..."

# Wait for containers to be ready
echo "⏳ Waiting for containers to be ready..."
sleep 15

# Check if containers are running
if ! docker-compose ps | grep -q "Up"; then
    echo "❌ Containers are not running. Please start them first with 'docker-compose up -d'"
    exit 1
fi

# Install Laravel 12
echo "📦 Installing Laravel 12..."
docker-compose exec app composer create-project laravel/laravel:^12.0 . --prefer-dist --no-interaction

# Set proper permissions
echo "🔐 Setting proper permissions..."
docker-compose exec app chown -R laravel:laravel /var/www
docker-compose exec app chmod -R 755 /var/www/storage
docker-compose exec app chmod -R 755 /var/www/bootstrap/cache

# Copy environment file
echo "⚙️  Configuring environment..."
docker-compose exec app cp env.example .env

# Generate application key
echo "🔑 Generating application key..."
docker-compose exec app php artisan key:generate

# Run migrations
echo "🗄️  Running database migrations..."
docker-compose exec app php artisan migrate

# Install Node.js dependencies (if package.json exists)
if docker-compose exec app test -f package.json; then
    echo "📦 Installing Node.js dependencies..."
    docker-compose exec app npm install
fi

# Clear caches
echo "🧹 Clearing caches..."
docker-compose exec app php artisan config:clear
docker-compose exec app php artisan cache:clear
docker-compose exec app php artisan view:clear
docker-compose exec app php artisan route:clear

echo "✅ Laravel 12 installation completed!"
echo ""
echo "🌐 Access your application at: http://localhost"
echo "📧 MailHog (Email testing): http://localhost:8025"
echo "🗄️  MySQL: localhost:3306"
echo "🔴 Redis: localhost:6379"
echo ""
echo "📚 Next steps:"
echo "  1. Visit http://localhost to see your Laravel application"
echo "  2. Check http://localhost:8025 for email testing"
echo "  3. Use 'make shell' to access the container"
echo "  4. Use 'make artisan ARGS=\"make:controller ExampleController\"' to create controllers"
echo ""
echo "🎉 Happy coding!" 