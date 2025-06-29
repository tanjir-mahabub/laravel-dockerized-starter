#!/bin/bash

# Laravel Dockerized Starter Environment Startup Script

echo "🚀 Starting Laravel Dockerized Starter Environment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Build and start containers
echo "📦 Building and starting containers..."
docker-compose up -d --build

# Wait for containers to be ready
echo "⏳ Waiting for containers to be ready..."
sleep 10

# Check if Laravel is already installed
if [ ! -f "src/composer.json" ]; then
    echo "📦 Laravel not found. Installing Laravel 12..."
    ./scripts/install-laravel.sh
else
    echo "✅ Laravel already installed."
fi

echo ""
echo "🎉 Environment is ready!"
echo ""
echo "🌐 Access points:"
echo "   Laravel Application: http://localhost"
echo "   MailHog (Email):     http://localhost:8025"
echo "   PHPMyAdmin:          http://localhost:8080"
echo "   Redis Commander:     http://localhost:8081"
echo ""
echo "📚 Useful commands:"
echo "   make shell           - Access PHP container"
echo "   make logs            - View container logs"
echo "   make down            - Stop containers"
echo "   make restart         - Restart containers"
echo ""
echo "🔧 Development tools:"
echo "   MySQL: localhost:3306 (laravel_user/laravel_password)"
echo "   Redis: localhost:6379"
echo ""
echo "Happy coding! 🚀" 