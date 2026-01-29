# 🐳 Docker Quick Reference Card

One-page reference for Docker development commands.

## 🚀 Quick Start

```bash
# Start development environment
make dev

# Start production environment  
make prod

# View all commands
make help
```

## 📦 Common Make Commands

| Command | Description |
|---------|-------------|
| `make dev` | Start development with hot reload |
| `make dev-build` | Build and start development |
| `make dev-down` | Stop development |
| `make prod` | Start production |
| `make prod-build` | Build and start production |
| `make logs` | View logs (CTRL+C to exit) |
| `make shell` | Open shell in container |
| `make ps` | List running containers |
| `make stats` | Show resource usage |
| `make clean` | Remove containers & volumes |
| `make rebuild` | Rebuild everything |

## 🔧 Docker Compose Commands

### Development
```bash
# Start
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up

# Start in background
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

# Stop
docker-compose -f docker-compose.yml -f docker-compose.dev.yml down

# View logs
docker-compose -f docker-compose.yml -f docker-compose.dev.yml logs -f
```

### Production
```bash
# Start
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# Stop
docker-compose -f docker-compose.yml -f docker-compose.prod.yml down
```

## 🐛 Debugging

```bash
# View logs
docker logs <container-name>
docker-compose logs -f <service-name>

# Execute command in running container
docker exec -it <container-name> /bin/sh
docker exec -it <container-name> bash

# Inspect container
docker inspect <container-name>

# View container processes
docker top <container-name>

# View resource usage
docker stats <container-name>
```

## 🏗️ Building

```bash
# Build images
docker-compose build

# Build without cache
docker-compose build --no-cache

# Build specific service
docker-compose build <service-name>

# Build specific stage
docker build --target development -t app:dev .
docker build --target production -t app:prod .
```

## 🧹 Cleanup

```bash
# Stop and remove containers
docker-compose down

# Remove containers and volumes
docker-compose down -v

# Remove containers, volumes, and images
docker-compose down -v --rmi all

# Prune unused resources
docker system prune

# Prune everything (careful!)
docker system prune -a --volumes
```

## 📊 Monitoring

```bash
# List containers
docker ps
docker ps -a  # Include stopped

# List images
docker images

# List volumes
docker volume ls

# List networks
docker network ls

# Disk usage
docker system df
```

## 🔍 Inspection

```bash
# Container details
docker inspect <container-name>

# Container logs
docker logs <container-name>
docker logs --tail 100 <container-name>
docker logs -f <container-name>  # Follow

# Container processes
docker top <container-name>

# Container changes
docker diff <container-name>
```

## 🌐 Networking

```bash
# List networks
docker network ls

# Inspect network
docker network inspect <network-name>

# Create network
docker network create <network-name>

# Connect container to network
docker network connect <network-name> <container-name>
```

## 💾 Volumes

```bash
# List volumes
docker volume ls

# Inspect volume
docker volume inspect <volume-name>

# Create volume
docker volume create <volume-name>

# Remove volume
docker volume rm <volume-name>

# Prune unused volumes
docker volume prune
```

## 🎯 Quickstart (Plaid)

```bash
# Start quickstart development
make quickstart-dev

# Stop quickstart
make quickstart-down

# View quickstart logs
make quickstart-logs

# Or manually
cd quickstart
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
```

## 🔐 Environment Variables

```bash
# Load from .env file (automatic)
docker-compose up

# Override environment variable
VARIABLE=value docker-compose up

# Pass environment variable
docker run -e VARIABLE=value image

# Use env file
docker run --env-file .env image
```

## 📝 Dockerfile Commands

```dockerfile
FROM        # Base image
WORKDIR     # Set working directory
COPY        # Copy files
ADD         # Copy files (with extraction)
RUN         # Execute command
CMD         # Default command
ENTRYPOINT  # Main command
EXPOSE      # Document port
ENV         # Set environment variable
ARG         # Build argument
VOLUME      # Create mount point
USER        # Set user
HEALTHCHECK # Health check command
LABEL       # Add metadata
```

## 🎨 Docker Compose Syntax

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
      target: production
    image: app:latest
    container_name: my-app
    ports:
      - "3000:3000"
    volumes:
      - ./src:/app/src
    environment:
      - NODE_ENV=production
    depends_on:
      - db
    networks:
      - app-network
    restart: unless-stopped

networks:
  app-network:
    driver: bridge

volumes:
  data:
```

## 🚨 Troubleshooting

| Problem | Solution |
|---------|----------|
| Port in use | Change port or kill process |
| Permission denied | Check file ownership |
| Build cache issues | Use `--no-cache` |
| Container keeps restarting | Check logs |
| Out of disk space | Run `docker system prune` |
| Slow on Windows/Mac | Use delegated mounts |

## 📱 URLs

- **Main Dashboard**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **Health Check**: http://localhost:3000/health

## 📚 Documentation

- Main Guide: `DOCKER_DEVELOPMENT_GUIDE.md`
- Docker Docs: https://docs.docker.com
- Compose Docs: https://docs.docker.com/compose

---

**Pro Tip**: Use `make help` to see all available commands!
