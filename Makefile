# Laravel Dockerized Starter Template - Makefile
# Provides convenient commands for development and deployment

.PHONY: help install start stop restart logs shell composer artisan migrate seed test clean deploy

# Default target
help:
	@echo "🚀 Laravel Dockerized Starter - Available Commands"
	@echo "=================================================="
	@echo ""
	@echo "📦 Setup & Installation:"
	@echo "  install     - Install dependencies and setup the project"
	@echo "  setup       - Run the setup script for new projects"
	@echo ""
	@echo "🐳 Docker Commands:"
	@echo "  start       - Start all Docker services"
	@echo "  stop        - Stop all Docker services"
	@echo "  restart     - Restart all Docker services"
	@echo "  logs        - View logs from all services"
	@echo "  shell       - Open shell in the app container"
	@echo ""
	@echo "🔧 Laravel Commands:"
	@echo "  composer    - Run composer commands (usage: make composer cmd='install')"
	@echo "  artisan     - Run artisan commands (usage: make artisan cmd='list')"
	@echo "  migrate     - Run database migrations"
	@echo "  seed        - Seed the database"
	@echo "  test        - Run tests"
	@echo ""
	@echo "🧹 Maintenance:"
	@echo "  clean       - Clean up containers, images, and volumes"
	@echo "  cache       - Clear Laravel caches"
	@echo ""
	@echo "🚀 Deployment:"
	@echo "  deploy      - Deploy to production (requires setup)"
	@echo ""

# Setup and installation
install:
	@echo "📦 Installing dependencies..."
	docker-compose exec app composer install
	@echo "✅ Dependencies installed"

setup:
	@echo "🚀 Running setup script..."
	@chmod +x scripts/setup-new-project.sh
	@./scripts/setup-new-project.sh

# Docker commands
start:
	@echo "🐳 Starting Docker services..."
	docker-compose up -d
	@echo "✅ Services started"

stop:
	@echo "🛑 Stopping Docker services..."
	docker-compose down
	@echo "✅ Services stopped"

restart:
	@echo "🔄 Restarting Docker services..."
	docker-compose restart
	@echo "✅ Services restarted"

logs:
	@echo "📋 Viewing logs..."
	docker-compose logs -f

shell:
	@echo "🐚 Opening shell in app container..."
	docker-compose exec app bash

# Laravel commands
composer:
	@if [ -z "$(cmd)" ]; then \
		echo "❌ Please specify a command: make composer cmd='install'"; \
		exit 1; \
	fi
	@echo "📦 Running composer $(cmd)..."
	docker-compose exec app composer $(cmd)

artisan:
	@if [ -z "$(cmd)" ]; then \
		echo "❌ Please specify a command: make artisan cmd='list'"; \
		exit 1; \
	fi
	@echo "🔧 Running artisan $(cmd)..."
	docker-compose exec app php artisan $(cmd)

migrate:
	@echo "🗄️  Running migrations..."
	docker-compose exec app php artisan migrate

seed:
	@echo "🌱 Seeding database..."
	docker-compose exec app php artisan db:seed

test:
	@echo "🧪 Running tests..."
	docker-compose exec app php artisan test

# Maintenance commands
clean:
	@echo "🧹 Cleaning up Docker resources..."
	docker-compose down -v --remove-orphans
	docker system prune -f
	@echo "✅ Cleanup completed"

cache:
	@echo "🗑️  Clearing Laravel caches..."
	docker-compose exec app php artisan cache:clear
	docker-compose exec app php artisan config:clear
	docker-compose exec app php artisan route:clear
	docker-compose exec app php artisan view:clear
	@echo "✅ Caches cleared"

# Development helpers
dev:
	@echo "🚀 Starting development environment..."
	docker-compose -f docker-compose.dev.yml up -d
	@echo "✅ Development environment started"

prod-local:
	@echo "🏭 Starting local production environment..."
	docker-compose -f docker-compose.prod.yml up -d
	@echo "✅ Local production environment started"

# Database commands
db-shell:
	@echo "🗄️  Opening MySQL shell..."
	docker-compose exec mysql mysql -u laravel_user -p laravel

db-backup:
	@echo "💾 Creating database backup..."
	docker-compose exec mysql mysqldump -u laravel_user -p laravel > backup_$(shell date +%Y%m%d_%H%M%S).sql
	@echo "✅ Backup created"

# Service-specific commands
nginx-logs:
	@echo "🌐 Viewing Nginx logs..."
	docker-compose logs -f nginx

mysql-logs:
	@echo "🗄️  Viewing MySQL logs..."
	docker-compose logs -f mysql

redis-logs:
	@echo "🔴 Viewing Redis logs..."
	docker-compose logs -f redis

# Health checks
health:
	@echo "🏥 Checking service health..."
	@echo "Laravel App: http://localhost"
	@echo "phpMyAdmin: http://localhost:8080"
	@echo "Redis Commander: http://localhost:8081"
	@echo "MailHog: http://localhost:8025"

# Deployment (placeholder - customize for your deployment platform)
deploy:
	@echo "🚀 Deploying to production..."
	@echo "⚠️  Please customize this command for your deployment platform"
	@echo "For Render: git push origin main"
	@echo "For Railway: railway up"
	@echo "For Heroku: git push heroku main" 