# 🚀 Cloud.io Platform - Quick Start Guide

Get your cloud platform running in under 2 minutes!

## ⚡ Fastest Way (Docker Compose)

```bash
# 1. Start the platform
docker-compose up -d

# 2. Open in browser
open http://localhost:3000

# That's it! 🎉
```

## 📋 What You Get

- ✅ **Home Page** - Overview of all cloud services
- ✅ **Virtual Machines** - VM configurations and pricing
- ✅ **Containers** - Kubernetes and container services
- ✅ **Bare Metal** - Dedicated server options
- ✅ **Confidential Compute** - Hardware security features
- ✅ **Clusters** - Managed database clusters
- ✅ **Pricing** - Transparent pricing for all services

## 🎯 Navigation

Click on any service in the navigation bar or use these direct links:
- Home: `http://localhost:3000#home`
- Virtual Machines: `http://localhost:3000#virtual-machines`
- Containers: `http://localhost:3000#containers`
- Bare Metal: `http://localhost:3000#bare-metal`
- Confidential Compute: `http://localhost:3000#confidential-compute`
- Clusters: `http://localhost:3000#clusters`
- Pricing: `http://localhost:3000#pricing`

## 🛠️ Common Commands

```bash
# View logs
docker-compose logs -f

# Stop the platform
docker-compose down

# Rebuild after changes
docker-compose up -d --build

# Check health
curl http://localhost:3000/health
```

## 📱 Test on Mobile

1. Find your local IP:
   ```bash
   # macOS/Linux
   ifconfig | grep "inet "
   
   # Windows
   ipconfig
   ```

2. Open on mobile device:
   ```
   http://YOUR_IP:3000
   ```

## 🎨 Customize

Edit these files to customize:
- **Colors**: `public/css/main.css` (CSS variables)
- **Content**: `public/js/components.js` (page templates)
- **Styles**: `public/css/components.css` (component styles)

## 🚢 Deploy to Production

### Render.com (Free)
```bash
git push origin main
# Then connect repo on Render.com
```

### Fly.io
```bash
flyctl launch
flyctl deploy
```

### Docker Hub
```bash
docker build -t yourusername/cloud-platform .
docker push yourusername/cloud-platform
```

## ❓ Troubleshooting

**Port 3000 already in use?**
```bash
# Use different port
docker-compose down
# Edit docker-compose.yml: change "3000:80" to "8080:80"
docker-compose up -d
```

**Changes not showing?**
```bash
# Hard refresh browser (Ctrl+Shift+R or Cmd+Shift+R)
# Or rebuild
docker-compose up -d --build
```

**Docker not installed?**
- Download from: https://www.docker.com/products/docker-desktop

## 📚 Full Documentation

See [CLOUD_PLATFORM_README.md](CLOUD_PLATFORM_README.md) for complete documentation.

---

**Enjoy your cloud platform! ☁️**
