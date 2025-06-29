# 🚀 Laravel Dockerized Starter Template

A production-ready Laravel starter template with Docker, Nginx, MySQL, Redis, and automated deployment to Render.

## ✨ Features

- **🐳 Dockerized Development**: Complete Docker setup with PHP 8.4, Nginx, MySQL 8.0, Redis, and MailHog
- **🚀 Production Ready**: Optimized for deployment on Render with single-container setup
- **🔧 Development Tools**: Includes phpMyAdmin, Redis Commander, and MailHog for local development
- **⚡ CI/CD Ready**: GitHub Actions workflow for automated deployment
- **🔒 Security**: Proper environment variable handling and security headers
- **📱 Modern Stack**: Laravel 11, PHP 8.4, MySQL 8.0, Redis 7

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Git

### 1. Create New Project

```bash
# Use this template to create a new repository
# Then clone your new repository
git clone <your-repo-url>
cd <your-project-name>
```

### 2. Start Development Environment

```bash
# Start all services
docker-compose up -d

# Or use the development configuration
docker-compose -f docker-compose.dev.yml up -d
```

### 3. Install Laravel Dependencies

```bash
# Enter the PHP container
docker-compose exec app bash

# Install dependencies
composer install

# Generate application key
php artisan key:generate

# Run migrations
php artisan migrate

# Exit container
exit
```

### 4. Access Your Application

- **Laravel App**: http://localhost
- **phpMyAdmin**: http://localhost:8080
- **Redis Commander**: http://localhost:8081
- **MailHog**: http://localhost:8025

## 🏗️ Project Structure

```
laravel-dockerized-starter/
├── docker/                    # Docker configurations
│   ├── mysql/                # MySQL configuration
│   ├── nginx/                # Nginx configuration
│   └── php/                  # PHP configuration
├── src/                      # Laravel application
├── docker-compose.yml        # Main Docker Compose
├── docker-compose.dev.yml    # Development configuration
├── docker-compose.prod.yml   # Production configuration
├── Dockerfile               # Production Dockerfile
├── render.yaml              # Render deployment config
└── .github/                 # GitHub Actions workflows
```

## 🐳 Docker Services

| Service             | Port      | Description         |
| ------------------- | --------- | ------------------- |
| **app**             | 9000      | PHP-FPM Application |
| **nginx**           | 80        | Web Server          |
| **mysql**           | 3306      | Database            |
| **redis**           | 6379      | Cache/Session Store |
| **mailhog**         | 1025/8025 | Email Testing       |
| **phpmyadmin**      | 8080      | Database Management |
| **redis-commander** | 8081      | Redis Management    |

## 🚀 Deployment

### Render Deployment

1. **Connect Repository**: Link your GitHub repository to Render
2. **Environment Variables**: Set the following in Render dashboard:

   ```
   DB_HOST=your-mysql-host
   DB_DATABASE=your-database-name
   DB_USERNAME=your-username
   DB_PASSWORD=your-password
   DB_PORT=3306
   APP_KEY=base64:your-generated-key
   ```

3. **Deploy**: Render will automatically deploy using the `Dockerfile` and `render.yaml`

### GitHub Actions (Alternative)

The template includes a GitHub Actions workflow for automated deployment. Set these secrets:

- `RENDER_SERVICE_ID`: Your Render service ID
- `RENDER_API_KEY`: Your Render API key

## 🔧 Configuration

### Environment Variables

Create `.env` files for different environments:

#### Local Development

```bash
# Copy example file
cp src/.env.example src/.env

# Update with local settings
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel_user
DB_PASSWORD=laravel_password
```

#### Production

Set these in your deployment platform (Render):

```bash
APP_ENV=production
APP_DEBUG=false
DB_HOST=your-production-host
DB_DATABASE=your-production-database
DB_USERNAME=your-production-username
DB_PASSWORD=your-production-password
```

### Database Setup

```bash
# Run migrations
docker-compose exec app php artisan migrate

# Seed database (if seeders exist)
docker-compose exec app php artisan db:seed

# Create a new migration
docker-compose exec app php artisan make:migration create_example_table
```

## 🛠️ Development Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Execute commands in container
docker-compose exec app php artisan list
docker-compose exec app composer install
docker-compose exec app npm install

# Access database
docker-compose exec mysql mysql -u laravel_user -p laravel

# Clear caches
docker-compose exec app php artisan cache:clear
docker-compose exec app php artisan config:clear
docker-compose exec app php artisan route:clear
```

## 🔒 Security

- Environment variables are properly handled
- Sensitive files are protected by Nginx
- Security headers are configured
- Database credentials are externalized

## 📝 Customization

### Adding New Services

1. Add service to `docker-compose.yml`
2. Update `docker-compose.dev.yml` if needed
3. Add any necessary configuration files

### Modifying PHP Extensions

Edit `docker/php/Dockerfile` to add/remove PHP extensions:

```dockerfile
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd
```

### Custom Nginx Configuration

Modify `docker/nginx/conf.d/app.conf` for custom routing or headers.

## 🐛 Troubleshooting

### Common Issues

1. **Port conflicts**: Change ports in `docker-compose.yml`
2. **Permission issues**: Run `chmod -R 755 src/storage src/bootstrap/cache`
3. **Database connection**: Check environment variables and MySQL service status
4. **Nginx errors**: Check logs with `docker-compose logs nginx`

### Logs

```bash
# View all logs
docker-compose logs

# View specific service logs
docker-compose logs app
docker-compose logs nginx
docker-compose logs mysql
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open-sourced software licensed under the [MIT license](LICENSE).

## 🙏 Acknowledgments

- [Laravel](https://laravel.com/) - The PHP framework
- [Docker](https://www.docker.com/) - Containerization platform
- [Render](https://render.com/) - Cloud deployment platform

---

**Happy Coding! 🎉**
