# Laravel 12 Docker Environment

A complete Docker development environment for Laravel 12 with PHP 8.4, MySQL 8.0, Redis, and Nginx.

## 🚀 Features

- **PHP 8.4** with FPM
- **MySQL 8.0** with optimized configuration
- **Redis 7** for caching and sessions
- **Nginx** with optimized Laravel configuration
- **MailHog** for email testing
- **Node.js 20** and **Yarn** for frontend assets
- **Composer** for PHP dependencies
- **Makefile** for easy command execution

## 📋 Prerequisites

- Docker
- Docker Compose
- Make (optional, but recommended)

## 🛠️ Quick Start

### 1. Clone and Setup

```bash
# Clone your project or navigate to the project directory
cd laravel-dockerized-starter

# Build and start all containers
# If you have make installed:
make setup
# Or follow the manual steps below
```

### 2. Manual Setup (If Make is not available)

```bash
# Build Docker images
docker-compose build

# Start containers
docker-compose up -d
```

#### If you see errors about missing Laravel files in src/ (e.g., 'Could not open input file: artisan'):

##### Install Laravel manually in the src directory:

```bash
# Make sure src/ is empty before running this!
docker-compose exec app composer create-project laravel/laravel .
```

### 3. Laravel Setup

```bash
# Copy environment file (if not already present)
docker-compose exec app cp .env.example .env

# Generate application key
docker-compose exec app php artisan key:generate

# Run migrations
docker-compose exec app php artisan migrate
```

## 🌐 Access Points

- **Laravel Application**: http://localhost
- **MailHog (Email Testing)**: http://localhost:8025
- **MySQL**: localhost:3306
- **Redis**: localhost:6379

## 🗄️ Database Configuration

By default, the project uses **MySQL** for development and testing. The relevant .env section is:

```env
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel_starter
DB_USERNAME=root
DB_PASSWORD=
```

If you want to use SQLite for quick tests, change the above to:

```env
DB_CONNECTION=sqlite
```

## 📁 Project Structure

```
laravel-dockerized-starter/
├── docker/
│   ├── nginx/
│   │   ├── Dockerfile
│   │   └── conf.d/
│   │       └── app.conf
│   ├── php/
│   │   ├── Dockerfile
│   │   └── local.ini
│   └── mysql/
│       └── my.cnf
├── src/
│   ├── .env
│   ├── .env.example
│   └── [Laravel application files]
├── docker-compose.yml
├── Makefile
└── README.md
```

## 🎯 Available Commands

### Docker Management

```bash
make build          # Build Docker images
make up             # Start containers
make down           # Stop containers
make restart        # Restart containers
make logs           # Show container logs
make shell          # Access PHP container shell
```

### Laravel Development

```bash
make install        # Install Composer dependencies
make update         # Update Composer dependencies
make test           # Run Laravel tests
make migrate        # Run database migrations
make seed           # Run database seeders
make fresh          # Fresh database with seeders
```

### Artisan Commands

```bash
make artisan ARGS="make:controller UserController"
make artisan ARGS="make:model User -m"
make artisan ARGS="route:list"
```

### Composer Commands

```bash
make composer ARGS="require package/name"
make composer ARGS="update"
make composer ARGS="dump-autoload"
```

## 🔧 Configuration

### Environment Variables

The main configuration is in `src/.env.example`. Copy it to `src/.env` and customize:

```env
# Database
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel_starter
DB_USERNAME=root
DB_PASSWORD=

# Redis
REDIS_HOST=redis
REDIS_PORT=6379

# Mail
MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
```

### PHP Configuration

PHP settings are configured in `docker/php/local.ini`:

- Memory limit: 512M
- Upload max filesize: 40M
- Max execution time: 600s
- Error reporting: E_ALL
- Date timezone: UTC

### MySQL Configuration

MySQL settings are in `docker/mysql/my.cnf`:

- Character set: utf8mb4
- InnoDB buffer pool: 256M
- Query cache: 32M
- Slow query logging enabled

### Nginx Configuration

Nginx configuration is in `docker/nginx/conf.d/app.conf`:

- Gzip compression enabled
- Security headers configured
- Static file caching
- Laravel routing support

## 🧪 Testing

### Run Tests

```bash
make test
```

### Run Specific Test

```bash
make artisan ARGS="test --filter=UserTest"
```

## 📧 Email Testing

MailHog is included for email testing:

1. Access MailHog UI: http://localhost:8025
2. Configure Laravel to use MailHog:
   ```env
   MAIL_MAILER=smtp
   MAIL_HOST=mailhog
   MAIL_PORT=1025
   ```

## 🔍 Debugging

### View Logs

```bash
make logs                    # All containers
docker-compose logs app      # PHP container only
docker-compose logs nginx    # Nginx container only
docker-compose logs mysql    # MySQL container only
```

### Access Container Shell

```bash
make shell                   # PHP container
docker-compose exec nginx sh # Nginx container
docker-compose exec mysql bash # MySQL container
```

## 🚀 Production Deployment

For production deployment, consider:

1. **Security**: Update default passwords
2. **SSL**: Configure SSL certificates
3. **Performance**: Optimize PHP and MySQL settings
4. **Monitoring**: Add health checks and monitoring
5. **Backup**: Configure database backups

### Production Build

```bash
make prod-build
make prod-up
```

## 🧹 Cleanup

### Remove Containers and Volumes

```bash
make clean
```

### Remove Everything (Images, Containers, Volumes)

```bash
make clean-all
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

## 🆘 Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 80, 3306, 6379 are available
2. **Permission issues**: Run `chmod -R 755 src/` if needed
3. **Database connection**: Wait for MySQL to fully start (30-60 seconds)
4. **Composer issues**: Clear composer cache with `make composer ARGS="clear-cache"`

### Reset Everything

```bash
make clean-all
make setup
```

## 📚 Additional Resources

- [Laravel Documentation](https://laravel.com/docs)
- [Docker Documentation](https://docs.docker.com/)
- [Nginx Configuration](https://nginx.org/en/docs/)
- [MySQL Documentation](https://dev.mysql.com/doc/)

## 🧪 Verifying the Project is Working

1. **Check containers:**

   ```bash
   docker-compose ps
   ```

   All services should show `Up`.

2. **Browser test:**
   Open [http://localhost](http://localhost) — you should see the Laravel welcome page.

3. **Artisan test:**

   ```bash
   docker-compose exec app php artisan --version
   ```

   You should see the Laravel version (e.g., `Laravel Framework 12.19.3`).

4. **MailHog:**
   Open [http://localhost:8025](http://localhost:8025) to view test emails.

## 🛠️ Troubleshooting

- **Nginx container keeps restarting with error:**

  ```
  invalid value "must-revalidate" in /etc/nginx/conf.d/app.conf:19
  ```

  **Solution:** Edit `docker/nginx/conf.d/app.conf` and remove `must-revalidate` from the `gzip_proxied` line. It should look like:

  ```nginx
  gzip_proxied expired no-cache no-store private auth;
  ```

  Then restart nginx:

  ```bash
  docker-compose restart nginx
  ```

- **PHP date.timezone warning:**
  ```
  PHP Warning: Invalid date.timezone value 'UTC ', using 'UTC' instead
  ```
  **Solution:** Edit `docker/php/local.ini` and remove the trailing space after `UTC`:
  ```ini
  date.timezone=UTC
  ```
  Then restart the app container:
  ```bash
  docker-compose restart app
  ```
