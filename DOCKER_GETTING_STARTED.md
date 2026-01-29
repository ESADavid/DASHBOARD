# 🐳 Getting Started with Docker Development

Quick guide to start developing with Docker containers.

## 🚀 Quick Start (30 seconds)

```bash
# Start development environment with hot reload
make dev
```

That's it! Your application is now running with:
- ✅ **Frontend**: http://localhost:3000
- ✅ **Backend**: http://localhost:8000
- ✅ **Hot Reload**: Enabled
- ✅ **Debugging**: Ready

## 📋 Prerequisites

- Docker Desktop installed and running
- Git (optional)
- Make (optional, but recommended)

## 🎯 Common Tasks

### Start Development

```bash
make dev
```

**What you get:**
- Live code reloading
- Development tools installed
- Interactive debugging
- Source code mounted as volumes

### View Logs

```bash
make logs
```

Press `CTRL+C` to exit.

### Stop Everything

```bash
make down
```

### Access Container Shell

```bash
make shell
```

### See All Commands

```bash
make help
```

## 🔥 Hot Reload in Action

### Main Dashboard
1. Edit `public/index.html`
2. Refresh browser
3. See changes immediately!

### Node.js Backend
1. Edit `quickstart/node/index.js`
2. Server restarts automatically
3. Changes applied instantly!

### Python Backend
1. Edit `quickstart/python/server.py`
2. Flask reloads automatically
3. Test new endpoints immediately!

### React Frontend
1. Edit `quickstart/frontend/src/App.tsx`
2. Browser updates without refresh
3. Hot Module Replacement (HMR) active!

## 🏭 Production Mode

```bash
# Build and run production version
make prod-build
```

**Production features:**
- Optimized images (50-70% smaller)
- Security hardening
- Resource limits
- Health checks

## 🐛 Debugging

### View Container Logs
```bash
make logs
```

### Access Container Shell
```bash
make shell
```

### Check Container Status
```bash
make ps
```

### View Resource Usage
```bash
make stats
```

## 🧹 Cleanup

```bash
# Remove containers and volumes
make clean

# Remove everything including images
make clean-all

# Prune unused Docker resources
make prune
```

## 📚 Learn More

- **Comprehensive Guide**: [DOCKER_DEVELOPMENT_GUIDE.md](DOCKER_DEVELOPMENT_GUIDE.md)
- **Quick Reference**: [DOCKER_QUICK_REFERENCE.md](DOCKER_QUICK_REFERENCE.md)
- **Implementation Details**: [DOCKER_IMPLEMENTATION_SUMMARY.md](DOCKER_IMPLEMENTATION_SUMMARY.md)

## 🆘 Troubleshooting

### Port Already in Use?
```bash
# Change port in docker-compose.yml
ports:
  - "3001:3000"  # Use 3001 instead
```

### Container Won't Start?
```bash
# Check logs
make logs

# Rebuild
make rebuild
```

### Changes Not Appearing?
```bash
# Restart development
make dev-down
make dev
```

### Need Help?
```bash
# See all available commands
make help
```

## 🎨 VS Code Integration

1. Install "Remote - Containers" extension
2. Press `F1`
3. Select "Remote-Containers: Reopen in Container"
4. Develop inside the container!

## ⚡ Pro Tips

1. **Use Make**: `make dev` is easier than long docker-compose commands
2. **Check Logs**: `make logs` shows what's happening
3. **Shell Access**: `make shell` for debugging inside container
4. **Clean Regularly**: `make clean` to free up space
5. **Read Docs**: Check `DOCKER_DEVELOPMENT_GUIDE.md` for advanced features

## 🎯 Next Steps

1. ✅ Start development: `make dev`
2. ✅ Make code changes
3. ✅ See changes instantly
4. ✅ Test production build: `make prod`
5. ✅ Deploy to cloud

## 📞 Support

- **Documentation**: See `DOCKER_DEVELOPMENT_GUIDE.md`
- **Commands**: Run `make help`
- **Docker Docs**: https://docs.docker.com

---

**Happy Developing! 🚀**

Start with `make dev` and you're ready to go!
