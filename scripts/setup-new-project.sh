#!/bin/bash

# Laravel Dockerized Starter - New Project Setup Script
# This script helps you set up a new project after using this template

set -e

echo "🚀 Laravel Dockerized Starter - Project Setup"
echo "=============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

print_status "Docker is running"

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    print_error "docker-compose is not installed. Please install Docker Compose and try again."
    exit 1
fi

print_status "Docker Compose is available"

# Create .env file if it doesn't exist
if [ ! -f "src/.env" ]; then
    print_info "Creating .env file from example..."
    cp src/.env.example src/.env
    print_status "Created src/.env file"
else
    print_warning "src/.env already exists, skipping creation"
fi

# Start the development environment
print_info "Starting Docker services..."
docker-compose up -d

# Wait for services to be ready
print_info "Waiting for services to be ready..."
sleep 10

# Check if services are running
if docker-compose ps | grep -q "Up"; then
    print_status "All services are running"
else
    print_error "Some services failed to start. Check logs with: docker-compose logs"
    exit 1
fi

# Install Composer dependencies
print_info "Installing Composer dependencies..."
docker-compose exec -T app composer install --no-interaction

# Generate application key
print_info "Generating Laravel application key..."
docker-compose exec -T app php artisan key:generate --no-interaction

# Run migrations
print_info "Running database migrations..."
docker-compose exec -T app php artisan migrate --no-interaction

# Set proper permissions
print_info "Setting proper permissions..."
docker-compose exec -T app chown -R www-data:www-data /var/www/storage
docker-compose exec -T app chown -R www-data:www-data /var/www/bootstrap/cache
docker-compose exec -T app chmod -R 755 /var/www/storage
docker-compose exec -T app chmod -R 755 /var/www/bootstrap/cache

print_status "Setup completed successfully!"

echo ""
echo "🎉 Your Laravel application is ready!"
echo ""
echo "📱 Access your application:"
echo "   • Laravel App: http://localhost"
echo "   • phpMyAdmin: http://localhost:8080"
echo "   • Redis Commander: http://localhost:8081"
echo "   • MailHog: http://localhost:8025"
echo ""
echo "🛠️  Useful commands:"
echo "   • View logs: docker-compose logs -f"
echo "   • Stop services: docker-compose down"
echo "   • Restart services: docker-compose restart"
echo "   • Execute commands: docker-compose exec app php artisan list"
echo ""
echo "📚 Next steps:"
echo "   1. Customize your Laravel application"
echo "   2. Set up your database models and migrations"
echo "   3. Configure your deployment environment variables"
echo "   4. Deploy to Render or your preferred platform"
echo ""
print_info "Happy coding! 🚀" 