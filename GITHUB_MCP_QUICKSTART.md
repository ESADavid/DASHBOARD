# 🚀 GitHub MCP Server - Quick Start Guide

**Get GitHub integration running in 15 minutes!**

---

## 📋 Prerequisites

- ✅ Docker Desktop installed and running
- ✅ GitHub account
- ✅ Git installed
- ✅ Node.js 18+ (for local development)

---

## 🔑 Step 1: Get Your GitHub Personal Access Token

1. Go to GitHub Settings: https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Give it a name: `MCP Server Token`
4. Select scopes:
   - ✅ `repo` (Full control of private repositories)
   - ✅ `read:org` (Read org and team membership)
   - ✅ `workflow` (Update GitHub Action workflows)
   - ✅ `read:user` (Read user profile data)
5. Click **"Generate token"**
6. **COPY THE TOKEN** - you won't see it again!

---

## 🛠️ Step 2: Configure Environment Variables

Create a file `.env.mcp` in the root directory:

```bash
# .env.mcp
GITHUB_PERSONAL_ACCESS_TOKEN=ghp_your_token_here
MCP_SERVER_PORT=9000
NODE_ENV=development
```

**Important**: Replace `ghp_your_token_here` with your actual token!

---

## 🐳 Step 3: Start the MCP Server

### Option A: Using Docker Compose (Recommended)

```powershell
# Start all services including MCP server
docker-compose -f docker-compose.dev.yml up -d

# Check if MCP server is running
docker ps | findstr mcp-server

# View MCP server logs
docker logs mcp-server -f
```

### Option B: Run MCP Server Standalone

```powershell
# Navigate to MCP server directory
cd mcp-server/github-mcp-server

# Install dependencies
npm install

# Set environment variable
$env:GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_token_here"

# Start the server
npm start
```

---

## ✅ Step 4: Verify Installation

### Test MCP Server Health

```powershell
# Test if server is responding
curl http://localhost:9000/health

# Expected response:
# {"status":"ok","service":"github-mcp-server"}
```

### Test GitHub Integration

```powershell
# List your repositories
curl http://localhost:9000/api/repos

# Get repository details
curl http://localhost:9000/api/repos/your-username/your-repo
```

---

## 🎯 Step 5: Access the Dashboard

1. Open your browser
2. Navigate to: http://localhost:3000
3. Click on **"GitHub Integration"** in the menu
4. You should see your repositories listed!

---

## 🔧 Available Endpoints

### Repository Operations
- `GET /api/repos` - List all repositories
- `GET /api/repos/:owner/:repo` - Get repository details
- `POST /api/repos` - Create new repository
- `GET /api/repos/:owner/:repo/contents/:path` - Get file contents

### Issue Operations
- `GET /api/repos/:owner/:repo/issues` - List issues
- `POST /api/repos/:owner/:repo/issues` - Create issue
- `PATCH /api/repos/:owner/:repo/issues/:number` - Update issue

### Pull Request Operations
- `GET /api/repos/:owner/:repo/pulls` - List pull requests
- `POST /api/repos/:owner/:repo/pulls` - Create pull request
- `PATCH /api/repos/:owner/:repo/pulls/:number` - Update pull request

### Search Operations
- `GET /api/search/code?q=query` - Search code
- `GET /api/search/issues?q=query` - Search issues
- `GET /api/search/repositories?q=query` - Search repositories

---

## 📝 Example Usage

### Create an Issue

```javascript
// Using fetch API
const response = await fetch('http://localhost:9000/api/repos/owner/repo/issues', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    title: 'Bug: Login not working',
    body: 'Users are unable to login with valid credentials',
    labels: ['bug', 'high-priority']
  })
});

const issue = await response.json();
console.log('Created issue:', issue.number);
```

### Search Code

```javascript
const response = await fetch('http://localhost:9000/api/search/code?q=function+login+repo:owner/repo');
const results = await response.json();
console.log('Found', results.total_count, 'matches');
```

### List Repositories

```javascript
const response = await fetch('http://localhost:9000/api/repos');
const repos = await response.json();
repos.forEach(repo => {
  console.log(`${repo.name} - ${repo.description}`);
});
```

---

## 🐛 Troubleshooting

### MCP Server Won't Start

**Problem**: Server fails to start or crashes immediately

**Solutions**:
1. Check if token is valid:
   ```powershell
   curl -H "Authorization: token ghp_your_token" https://api.github.com/user
   ```
2. Verify environment variable is set:
   ```powershell
   echo $env:GITHUB_PERSONAL_ACCESS_TOKEN
   ```
3. Check Docker logs:
   ```powershell
   docker logs mcp-server
   ```

### Port Already in Use

**Problem**: Port 9000 is already in use

**Solution**: Change the port in `.env.mcp`:
```bash
MCP_SERVER_PORT=9001
```

### Authentication Errors

**Problem**: Getting 401 Unauthorized errors

**Solutions**:
1. Regenerate GitHub token with correct scopes
2. Update `.env.mcp` with new token
3. Restart MCP server:
   ```powershell
   docker-compose restart mcp-server
   ```

### Rate Limiting

**Problem**: Getting 403 rate limit errors

**Solution**: GitHub API has rate limits:
- Authenticated: 5,000 requests/hour
- Unauthenticated: 60 requests/hour

Wait for the rate limit to reset or use a different token.

---

## 🔐 Security Best Practices

1. **Never commit tokens to Git**
   - Add `.env.mcp` to `.gitignore`
   - Use environment variables in production

2. **Rotate tokens regularly**
   - Generate new tokens every 90 days
   - Revoke old tokens immediately

3. **Use minimal scopes**
   - Only grant necessary permissions
   - Review token scopes periodically

4. **Monitor token usage**
   - Check GitHub settings for active tokens
   - Review access logs regularly

---

## 📚 Next Steps

1. **Explore the API**: See `GITHUB_MCP_API.md` for complete API reference
2. **Build integrations**: Check `GITHUB_MCP_USAGE.md` for examples
3. **Deploy to production**: Follow `GITHUB_MCP_DEPLOYMENT.md`

---

## 🆘 Getting Help

- **Documentation**: See `docs/` folder
- **GitHub Issues**: https://github.com/github/github-mcp-server/issues
- **MCP Protocol**: https://modelcontextprotocol.io

---

## ✅ Quick Checklist

- [ ] GitHub token generated
- [ ] `.env.mcp` file created
- [ ] MCP server running
- [ ] Health check passing
- [ ] Can list repositories
- [ ] Dashboard accessible

---

**Ready to integrate GitHub into your dashboard! 🎉**
