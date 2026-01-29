# 🚀 GitHub MCP Server - Complete Setup Guide

**Integrate GitHub MCP Server with Your Banking Dashboard**

---

## 📋 What is GitHub MCP Server?

The GitHub MCP (Model Context Protocol) Server is a Go-based tool that allows AI assistants to interact with GitHub repositories, issues, pull requests, and more through a standardized protocol.

**Key Features:**
- Repository management and code browsing
- Issue and PR automation
- GitHub Actions workflow monitoring
- Code security scanning
- Team collaboration tools

---

## 🎯 Integration Overview

This guide will help you:
1. ✅ Set up the GitHub MCP server locally using Docker
2. ✅ Configure it to work with your dashboard
3. ✅ Create documentation for usage

---

## 🔑 Step 1: Create GitHub Personal Access Token

1. Go to: https://github.com/settings/tokens/new
2. Token name: `Dashboard MCP Server`
3. Select scopes:
   - ✅ `repo` - Full control of repositories
   - ✅ `read:org` - Read org and team membership
   - ✅ `workflow` - Update GitHub Actions workflows
   - ✅ `read:user` - Read user profile data
   - ✅ `gist` - Create and manage gists
   - ✅ `notifications` - Access notifications
   - ✅ `read:project` - Read project data
   - ✅ `security_events` - View security events
4. Click **"Generate token"**
5. **COPY THE TOKEN** immediately!

---

## 🐳 Step 2: Run MCP Server with Docker

### Option A: Quick Start (Recommended)

```powershell
# Set your GitHub token
$env:GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_token_here"

# Run the MCP server
docker run -i --rm `
  -e GITHUB_PERSONAL_ACCESS_TOKEN `
  -p 9000:9000 `
  ghcr.io/github/github-mcp-server
```

### Option B: Run with Specific Toolsets

```powershell
# Run with only specific toolsets enabled
docker run -i --rm `
  -e GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_token_here" `
  -e GITHUB_TOOLSETS="repos,issues,pull_requests,actions" `
  ghcr.io/github/github-mcp-server
```

### Option C: Run in Read-Only Mode

```powershell
# Safe mode - no write operations
docker run -i --rm `
  -e GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_token_here" `
  -e GITHUB_READ_ONLY=1 `
  ghcr.io/github/github-mcp-server
```

---

## 🔧 Step 3: Verify Installation

### Test the Server

```powershell
# The server runs in stdio mode by default
# It communicates via standard input/output

# To test, you can use the CLI utilities:
docker run -it --rm ghcr.io/github/github-mcp-server tool-search "issue" --max-results 5
```

---

## 📦 Step 4: Available Toolsets

The GitHub MCP Server organizes tools into toolsets. Here are the most useful ones:

| Toolset | Description | Use Case |
|---------|-------------|----------|
| `context` | User and team context | **Recommended** - Know who you are |
| `repos` | Repository operations | Browse code, create repos |
| `issues` | Issue management | Create, update, search issues |
| `pull_requests` | PR operations | Create, review, merge PRs |
| `actions` | GitHub Actions | Monitor workflows, view logs |
| `code_security` | Security scanning | View security alerts |
| `gists` | Gist management | Create, update gists |
| `notifications` | Notifications | Manage GitHub notifications |
| `projects` | GitHub Projects | Manage project boards |

### Default Toolsets

If you don't specify toolsets, these are enabled by default:
- `context`
- `repos`
- `issues`
- `pull_requests`
- `users`

---

## 🎨 Step 5: Integration with Dashboard

### Using MCP Server with VS Code

The GitHub MCP server is designed to work with MCP-compatible hosts like VS Code, Claude Desktop, Cursor, etc.

**For VS Code (1.101+):**

1. Create `.vscode/mcp.json` in your project:

```json
{
  "inputs": [
    {
      "type": "promptString",
      "id": "github_token",
      "description": "GitHub Personal Access Token",
      "password": true
    }
  ],
  "servers": {
    "github": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${input:github_token}"
      }
    }
  }
}
```

2. Toggle Agent mode in VS Code Copilot Chat
3. The server will start automatically

---

## 🔐 Security Best Practices

### 1. Token Storage

**DO:**
- ✅ Store tokens in environment variables
- ✅ Use `.env` files (add to `.gitignore`)
- ✅ Rotate tokens regularly (every 90 days)
- ✅ Use minimal required scopes

**DON'T:**
- ❌ Commit tokens to Git
- ❌ Share tokens in chat/email
- ❌ Use tokens with excessive permissions
- ❌ Hardcode tokens in scripts

### 2. Environment Variables

Create `.env.mcp`:
```env
GITHUB_PERSONAL_ACCESS_TOKEN=ghp_your_token_here
GITHUB_TOOLSETS=repos,issues,pull_requests
GITHUB_READ_ONLY=0
```

Add to `.gitignore`:
```
.env.mcp
*.env
```

### 3. Token Permissions

Minimum scopes for read-only access:
- `repo` (read-only operations)
- `read:org`
- `read:user`

Additional scopes for write operations:
- `workflow` (GitHub Actions)
- `gist` (Gist management)
- `notifications` (Notification management)

---

## 🛠️ Advanced Configuration

### Custom Toolsets

```powershell
# Enable specific toolsets
docker run -i --rm `
  -e GITHUB_PERSONAL_ACCESS_TOKEN="ghp_token" `
  -e GITHUB_TOOLSETS="repos,issues,actions,code_security" `
  ghcr.io/github/github-mcp-server
```

### Specific Tools Only

```powershell
# Enable only specific tools
docker run -i --rm `
  -e GITHUB_PERSONAL_ACCESS_TOKEN="ghp_token" `
  -e GITHUB_TOOLS="get_file_contents,issue_read,create_pull_request" `
  ghcr.io/github/github-mcp-server
```

### Insiders Mode (Beta Features)

```powershell
# Access experimental features
docker run -i --rm `
  -e GITHUB_PERSONAL_ACCESS_TOKEN="ghp_token" `
  -e GITHUB_INSIDERS=true `
  ghcr.io/github/github-mcp-server
```

### GitHub Enterprise

```powershell
# For GitHub Enterprise Server
docker run -i --rm `
  -e GITHUB_PERSONAL_ACCESS_TOKEN="ghp_token" `
  -e GITHUB_HOST="https://github.yourcompany.com" `
  ghcr.io/github/github-mcp-server
```

---

## 📊 Available Tools

### Repository Tools
- `get_file_contents` - Read files from repos
- `search_code` - Search code across repos
- `create_repository` - Create new repos
- `fork_repository` - Fork repos
- `create_branch` - Create branches
- `push_files` - Push multiple files

### Issue Tools
- `issue_read` - Get issue details
- `issue_write` - Create/update issues
- `list_issues` - List issues
- `search_issues` - Search issues
- `add_issue_comment` - Comment on issues

### Pull Request Tools
- `pull_request_read` - Get PR details
- `create_pull_request` - Create PRs
- `update_pull_request` - Update PRs
- `merge_pull_request` - Merge PRs
- `list_pull_requests` - List PRs

### GitHub Actions Tools
- `actions_list` - List workflows
- `actions_get` - Get workflow details
- `get_job_logs` - Get job logs

### Security Tools
- `list_code_scanning_alerts` - Code scanning
- `list_dependabot_alerts` - Dependabot alerts
- `list_secret_scanning_alerts` - Secret scanning

---

## 🐛 Troubleshooting

### Server Won't Start

**Problem:** Docker image fails to pull

**Solution:**
```powershell
# Logout and re-login to GitHub Container Registry
docker logout ghcr.io
docker pull ghcr.io/github/github-mcp-server
```

### Authentication Errors

**Problem:** 401 Unauthorized

**Solutions:**
1. Verify token is valid:
   ```powershell
   curl -H "Authorization: token ghp_your_token" https://api.github.com/user
   ```
2. Check token scopes in GitHub settings
3. Generate new token with correct scopes

### Rate Limiting

**Problem:** 403 Rate limit exceeded

**Info:**
- Authenticated: 5,000 requests/hour
- Unauthenticated: 60 requests/hour

**Solution:** Wait for rate limit reset or use different token

---

## 📚 Example Use Cases

### 1. Browse Repository Code

```
Ask: "Show me the contents of README.md in owner/repo"
Tool: get_file_contents
```

### 2. Create an Issue

```
Ask: "Create an issue titled 'Bug: Login fails' in owner/repo"
Tool: issue_write (method: create)
```

### 3. Search Code

```
Ask: "Find all TypeScript files that import React in owner/repo"
Tool: search_code
```

### 4. Monitor Workflows

```
Ask: "Show me the latest workflow runs in owner/repo"
Tool: actions_list (method: list_workflow_runs)
```

### 5. Review Security Alerts

```
Ask: "List all Dependabot alerts in owner/repo"
Tool: list_dependabot_alerts
```

---

## 🎯 Next Steps

1. ✅ **Test the server** - Run basic commands
2. ✅ **Configure VS Code** - Set up MCP integration
3. ✅ **Explore tools** - Try different operations
4. ✅ **Secure tokens** - Follow security best practices
5. ✅ **Customize toolsets** - Enable only what you need

---

## 📖 Additional Resources

- **Official Docs**: https://github.com/github/github-mcp-server
- **MCP Protocol**: https://modelcontextprotocol.io
- **GitHub API**: https://docs.github.com/en/rest
- **VS Code MCP**: https://code.visualstudio.com/docs/copilot/chat/mcp-servers

---

## ✅ Quick Checklist

- [ ] GitHub Personal Access Token created
- [ ] Docker installed and running
- [ ] MCP server image pulled
- [ ] Server tested with token
- [ ] VS Code configured (if using)
- [ ] Security best practices followed
- [ ] Documentation reviewed

---

**Ready to integrate GitHub into your AI workflows! 🎉**
