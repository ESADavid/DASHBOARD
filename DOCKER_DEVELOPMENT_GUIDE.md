# 🐳 Docker Development Guide

Complete guide for developing with Docker containers following best practices from [Docker's official documentation](https://docs.docker.com/get-started/introduction/develop-with-containers/).

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Development Workflow](#development-workflow)
- [Production Deployment](#production-deployment)
- [Multi-Stage Builds](#multi-stage-builds)
- [Hot Reload & Live Development](#hot-reload--live-development)
- [Debugging](#debugging)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

---

## 🚀 Quick Start

### Prerequisites

- Docker Desktop installed and running
- Git
- Make (optional, but recommended)

### Start Development Environment

```bash
# Using Make (recommended)
make dev

# Or using Docker Compose directly
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
```

Your application will be available at:
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000

---

## 💻 Development Workflow

### Using Make Commands

We provide a comprehensive Makefile for common operations:

```bash
# View all available commands
make help

# Development
make dev              # Start development environment
make dev-build        # Build and start development
make dev-down         # Stop development environment

# Production
make prod             # Start production environment
make prod-build       # Build and start production
make prod-down        # Stop production environment

# Monitoring
make logs             # View logs
make ps               # List running containers
make shell            # Open shell in container
make stats            # Show resource usage

# Cleanup
make clean            # Remove containers and volumes
make clean-all        # Remove everything including images
```

### Development with Hot Reload

The development configuration includes automatic code reloading:

#### Main Dashboard (Nginx)
- Changes to `public/` directory are immediately reflected
- No rebuild required

#### Node.js Backend
- Uses `nodemon` for automatic restart on file changes
- Edit `quickstart/node/index.js` and see changes instantly

#### Python Backend
- Flask auto-reload enabled in development mode
- Edit `quickstart/python/server.py` for instant updates

#### React Frontend
- Hot Module Replacement (HMR) enabled
- Changes to `quickstart/frontend/src/` update in browser automatically

### File Structure

```
DASHBOARD/
├── docker-compose.yml           # Base configuration
├── docker-compose.dev.yml       # Development overrides
├── docker-compose.prod.yml      # Production overrides
├── Dockerfile                   # Production Dockerfile
├── Dockerfile.dev               # Development Dockerfile (multi-stage)
├── Makefile                     # Convenient commands
├── .devcontainer/               # VS Code Dev Container config
│   └── devcontainer.json
└── quickstart/
    ├── docker-compose.yml       # Quickstart base config
    ├── docker-compose.dev.yml   # Quickstart dev overrides
    ├── node/
    │   ├── Dockerfile           # Original Node Dockerfile
    │   └── Dockerfile.dev       # Multi-stage Node Dockerfile
    └── python/
        ├── Dockerfile           # Original Python Dockerfile
        └── Dockerfile.dev       # Multi-stage Python Dockerfile
```

---

## 🏭 Production Deployment

### Build Production Images

```bash
# Using Make
make prod-build

# Or using Docker Compose
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
```

### Production Features

The production configuration includes:

✅ **Multi-stage builds** - Smaller image sizes
✅ **Non-root users** - Enhanced security
✅ **Read-only filesystems** - Additional security layer
✅ **Resource limits** - CPU and memory constraints
✅ **Health checks** - Automatic container monitoring
✅ **Optimized dependencies** - Production-only packages
✅ **Security hardening** - No unnecessary tools or privileges

### Production Environment Variables

Set these in your production environment:

```bash
NODE_ENV=production
FLASK_ENV=production
DEBUG=false
```

---

## 🏗️ Multi-Stage Builds

Our Dockerfiles use multi-stage builds for optimization:

### Benefits

1. **Smaller Images**: Only production dependencies in final image
2. **Faster Builds**: Cached layers for dependencies
3. **Security**: No build tools in production images
4. **Flexibility**: Same Dockerfile for dev and prod

### Example: Node.js Multi-Stage Build

```dockerfile
# Stage 1: Base
FROM node:20-alpine AS base
WORKDIR /opt/app

# Stage 2: Development
FROM base AS development
RUN npm install
CMD ["nodemon", "index.js"]

# Stage 3: Dependencies
FROM base AS dependencies
RUN npm ci --only=production

# Stage 4: Production
FROM node:20-alpine AS production
COPY --from=dependencies /opt/app/node_modules ./node_modules
CMD ["node", "index.js"]
```

### Building Specific Stages

```bash
# Build development stage
docker build --target development -t app:dev .

# Build production stage
docker build --target production -t app:prod .
```

---

## 🔥 Hot Reload & Live Development

### How It Works

Development containers use volume mounts to sync code:

```yaml
services:
  node:
    volumes:
      - ./node:/opt/app:delegated  # Mount source code
      - /opt/app/node_modules      # Preserve node_modules
```

### Volume Mount Options

- **delegated**: Optimized for host-to-container writes (macOS/Windows)
- **cached**: Optimized for container-to-host reads
- **consistent**: Strict consistency (slower but safer)

### Enabling Hot Reload

#### Node.js (nodemon)
```bash
# Already configured in Dockerfile.dev
CMD ["nodemon", "--watch", ".", "--ext", "js,json", "index.js"]
```

#### Python (Flask)
```bash
# Already configured in Dockerfile.dev
ENV FLASK_ENV=development
CMD ["python", "-m", "flask", "run", "--reload"]
```

#### React (Create React App)
```bash
# Already configured
CHOKIDAR_USEPOLLING=true
WATCHPACK_POLLING=true
```

---

## 🐛 Debugging

### Attach to Running Container

```bash
# Using Make
make shell

# Or using Docker directly
docker exec -it cloud-io-platform /bin/sh
```

### View Logs

```bash
# All services
make logs

# Specific service
docker-compose logs -f cloud-platform

# Last 100 lines
docker-compose logs --tail=100 cloud-platform
```

### Debug Node.js with Inspector

Add to `docker-compose.dev.yml`:

```yaml
services:
  node:
    command: ["node", "--inspect=0.0.0.0:9229", "index.js"]
    ports:
      - "9229:9229"
```

Connect with Chrome DevTools: `chrome://inspect`

### Debug Python with pdb

Add breakpoint in code:
```python
import pdb; pdb.set_trace()
```

Attach to container:
```bash
docker attach <container-id>
```

### VS Code Dev Containers

Open project in VS Code and use the Dev Container:

1. Install "Remote - Containers" extension
2. Press `F1` → "Remote-Containers: Reopen in Container"
3. VS Code runs inside the container with full debugging support

---

## ✅ Best Practices

### 1. Use .dockerignore

Exclude unnecessary files from build context:

```
# .dockerignore
node_modules
npm-debug.log
.git
.env
*.md
.vscode
```

### 2. Leverage Build Cache

Order Dockerfile instructions from least to most frequently changing:

```dockerfile
# ✅ Good - Dependencies cached
COPY package*.json ./
RUN npm install
COPY . .

# ❌ Bad - Cache invalidated on any file change
COPY . .
RUN npm install
```

### 3. Use Specific Image Tags

```dockerfile
# ✅ Good - Reproducible builds
FROM node:20-alpine

# ❌ Bad - Unpredictable updates
FROM node:latest
```

### 4. Run as Non-Root User

```dockerfile
# Create and use non-root user
RUN adduser -D -u 1001 appuser
USER appuser
```

### 5. Multi-Stage Builds

Always use multi-stage builds for production:

```dockerfile
FROM node:20-alpine AS build
# Build steps...

FROM node:20-alpine AS production
COPY --from=build /app/dist ./dist
```

### 6. Health Checks

Add health checks to all services:

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --quiet --tries=1 --spider http://localhost/health || exit 1
```

### 7. Environment Variables

Use `.env` files for local development:

```bash
# .env
NODE_ENV=development
DEBUG=true
```

Never commit `.env` files with secrets!

### 8. Resource Limits

Set resource limits in production:

```yaml
services:
  app:
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
```

---

## 🔧 Troubleshooting

### Port Already in Use

```bash
# Find process using port 3000
netstat -ano | findstr :3000

# Kill process (Windows)
taskkill /PID <PID> /F

# Or change port in docker-compose.yml
ports:
  - "3001:3000"
```

### Container Keeps Restarting

```bash
# Check logs
docker logs <container-id>

# Check health status
docker inspect <container-id> | grep -A 10 Health
```

### Volume Mount Not Working

```bash
# Verify volume mounts
docker inspect <container-id> | grep -A 20 Mounts

# On Windows, ensure drive sharing is enabled in Docker Desktop
```

### Build Cache Issues

```bash
# Force rebuild without cache
docker-compose build --no-cache

# Or using Make
make rebuild
```

### Permission Denied Errors

```bash
# Fix ownership (Linux/macOS)
sudo chown -R $USER:$USER .

# Or run container as current user
docker-compose run --user $(id -u):$(id -g) app
```

### Out of Disk Space

```bash
# Clean up unused resources
make prune

# Or more aggressive cleanup
docker system prune -a --volumes
```

### Slow Performance on Windows/macOS

Use delegated volume mounts:

```yaml
volumes:
  - ./src:/app/src:delegated
```

### Network Issues

```bash
# Recreate network
docker-compose down
docker network prune
docker-compose up
```

---

## 📚 Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Multi-Stage Builds](https://docs.docker.com/build/building/multi-stage/)
- [Docker Security](https://docs.docker.com/engine/security/)

---

## 🎯 Quick Reference

### Common Commands

```bash
# Start development
make dev

# View logs
make logs

# Stop everything
make down

# Clean up
make clean

# Shell access
make shell

# Check status
make ps

# View resource usage
make stats
```

### File Locations

- **Main Dockerfile**: `Dockerfile` (production)
- **Dev Dockerfile**: `Dockerfile.dev` (multi-stage)
- **Base Compose**: `docker-compose.yml`
- **Dev Compose**: `docker-compose.dev.yml`
- **Prod Compose**: `docker-compose.prod.yml`
- **Make Commands**: `Makefile`

---

**Happy Developing! 🚀**

For questions or issues, refer to the troubleshooting section or check the Docker documentation.
