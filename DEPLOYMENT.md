# 🚀 Deployment Guide

This guide will help you deploy your Laravel Dockerized project to free cloud platforms with CI/CD.

## 📋 Prerequisites

- GitHub repository with your Laravel project
- Account on your chosen cloud platform
- Basic understanding of environment variables

## 🎯 Quick Deployment Options

### Option 1: Railway (Recommended)

**Why Railway?**

- Native Docker support
- Easy GitHub integration
- Automatic deployments
- Good free tier ($5/month credit)

**Steps:**

1. **Sign up:** [railway.app](https://railway.app)
2. **Connect GitHub:** Link your repository
3. **Deploy:**
   ```bash
   # Railway will auto-detect your Docker setup
   # Just push to main branch to deploy
   git push origin main
   ```

**Environment Variables to set in Railway:**

```env
APP_ENV=production
APP_DEBUG=false
APP_KEY=your-generated-key
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel_starter
DB_USERNAME=root
DB_PASSWORD=your-secure-password
REDIS_HOST=redis
MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
```

### Option 2: Render

**Why Render?**

- Easy setup
- Automatic HTTPS
- Good documentation

**Steps:**

1. **Sign up:** [render.com](https://render.com)
2. **Create Web Service:**
   - Connect GitHub repo
   - Choose "Docker" environment
   - Build Command: `docker-compose -f docker-compose.prod.yml build`
   - Start Command: `docker-compose -f docker-compose.prod.yml up`
3. **Set Environment Variables** (same as Railway)

### Option 3: Fly.io

**Why Fly.io?**

- Global edge deployment
- Generous free tier
- Fast performance

**Steps:**

1. **Install Fly CLI:**
   ```bash
   curl -L https://fly.io/install.sh | sh
   ```
2. **Login:**
   ```bash
   fly auth login
   ```
3. **Deploy:**
   ```bash
   fly launch
   fly deploy
   ```

## 🔧 CI/CD Setup

### GitHub Actions (Already configured)

The `.github/workflows/deploy.yml` file is already set up for:

- **Testing:** Runs PHPUnit tests on every push
- **Deployment:** Deploys to Railway on main branch push

### Required Secrets

Add these to your GitHub repository secrets:

**For Railway:**

- `RAILWAY_TOKEN`: Your Railway API token
- `RAILWAY_SERVICE`: Your Railway service ID

**For Render:**

- `RENDER_API_KEY`: Your Render API key
- `RENDER_SERVICE_ID`: Your Render service ID

## 🛠️ Production Configuration

### 1. Environment Variables

Create a production `.env` file:

```env
APP_NAME=Laravel
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-app-url.com
APP_KEY=your-generated-key

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel_starter
DB_USERNAME=root
DB_PASSWORD=secure-password

REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_FROM_ADDRESS="noreply@yourdomain.com"
MAIL_FROM_NAME="${APP_NAME}"

CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
```

### 2. Security Checklist

- [ ] Set `APP_DEBUG=false`
- [ ] Generate strong `APP_KEY`
- [ ] Use secure database passwords
- [ ] Enable HTTPS
- [ ] Set up proper CORS headers
- [ ] Configure rate limiting

### 3. Performance Optimization

- [ ] Enable Redis for caching
- [ ] Configure queue workers
- [ ] Optimize database queries
- [ ] Enable gzip compression
- [ ] Set up CDN for assets

## 📊 Monitoring & Maintenance

### Health Checks

Add health check endpoints:

```php
// routes/web.php
Route::get('/health', function () {
    return response()->json(['status' => 'healthy']);
});
```

### Logs

Monitor your application logs:

```bash
# Railway
railway logs

# Render
render logs

# Fly.io
fly logs
```

### Database Backups

Set up automated backups:

```bash
# MySQL backup
mysqldump -u root -p laravel_starter > backup.sql

# Restore
mysql -u root -p laravel_starter < backup.sql
```

## 🚨 Troubleshooting

### Common Issues

1. **Database Connection Failed**

   - Check environment variables
   - Ensure MySQL container is running
   - Verify network connectivity

2. **Permission Denied**

   ```bash
   chmod -R 755 storage bootstrap/cache
   ```

3. **Memory Issues**

   - Increase PHP memory limit
   - Optimize Docker resources

4. **SSL/HTTPS Issues**
   - Configure SSL certificates
   - Update APP_URL to use HTTPS

### Debug Commands

```bash
# Check container status
docker-compose ps

# View logs
docker-compose logs app

# Access container
docker-compose exec app bash

# Run migrations
docker-compose exec app php artisan migrate
```

## 📈 Scaling

### Horizontal Scaling

- Use load balancers
- Implement Redis clustering
- Set up database replication

### Vertical Scaling

- Increase container resources
- Optimize PHP settings
- Use CDN for static assets

## 🔒 Security Best Practices

1. **Environment Variables**

   - Never commit `.env` files
   - Use secure passwords
   - Rotate keys regularly

2. **Database Security**

   - Use strong passwords
   - Limit database access
   - Enable SSL connections

3. **Application Security**
   - Keep dependencies updated
   - Enable CSRF protection
   - Implement rate limiting

## 📞 Support

- **Railway:** [docs.railway.app](https://docs.railway.app)
- **Render:** [render.com/docs](https://render.com/docs)
- **Fly.io:** [fly.io/docs](https://fly.io/docs)
- **Laravel:** [laravel.com/docs](https://laravel.com/docs)

---

**Happy Deploying! 🚀**
