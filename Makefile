.PHONY: help build up down restart logs shell composer install update test artisan migrate seed fresh

# Default target
help:
	@echo "Available commands:"
	@echo "  build     - Build Docker images"
	@echo "  up        - Start all containers"
	@echo "  down      - Stop all containers"
	@echo "  restart   - Restart all containers"
	@echo "  logs      - Show container logs"
	@echo "  shell     - Access PHP container shell"
	@echo "  composer  - Run composer commands"
	@echo "  install   - Install Laravel dependencies"
	@echo "  update    - Update Laravel dependencies"
	@echo "  test      - Run Laravel tests"
	@echo "  artisan   - Run Laravel artisan commands"
	@echo "  migrate   - Run database migrations"
	@echo "  seed      - Run database seeders"
	@echo "  fresh     - Fresh database with seeders"

# Docker commands
build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose restart

logs:
	docker-compose logs -f

shell:
	docker-compose exec app bash

# Composer commands
composer:
	docker-compose exec app composer $(ARGS)

install:
	docker-compose exec app composer install

update:
	docker-compose exec app composer update

# Laravel commands
test:
	docker-compose exec app php artisan test

artisan:
	docker-compose exec app php artisan $(ARGS)

migrate:
	docker-compose exec app php artisan migrate

seed:
	docker-compose exec app php artisan db:seed

fresh:
	docker-compose exec app php artisan migrate:fresh --seed

# Setup commands
setup: build up
	@echo "Waiting for containers to be ready..."
	@sleep 10
	@echo "Setting up Laravel application..."
	docker-compose exec app composer install
	docker-compose exec app cp env.example .env
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan migrate
	@echo "Setup complete! Visit http://localhost"

# Development commands
dev: up
	@echo "Development environment started!"
	@echo "Laravel: http://localhost"
	@echo "MailHog: http://localhost:8025"
	@echo "MySQL: localhost:3306"
	@echo "Redis: localhost:6379"

# Production-like commands
prod-build:
	docker-compose -f docker-compose.yml build --no-cache

prod-up:
	docker-compose -f docker-compose.yml up -d

# Cleanup commands
clean:
	docker-compose down -v
	docker system prune -f

clean-all:
	docker-compose down -v --rmi all
	docker system prune -af 