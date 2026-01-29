# 🚀 GitHub MCP Server - Quick Reference Card

**One-page reference for GitHub MCP Server integration**

---

## ⚡ Quick Start (3 Commands)

```powershell
# 1. Get your GitHub token from: https://github.com/settings/tokens/new
# 2. Set environment variable
$env:GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_token_here"

# 3. Run the server
docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN ghcr.io/github/github-mcp-server
```

---

## 📋 Required Token Scopes

**Minimum (Read-Only):**
- ✅ `repo` - Repository access
- ✅ `read:org` - Organization access
- ✅ `read:user` - User profile

**Full Access:**
- ✅ All above + `workflow`, `gist`, `notifications`, `read:project`, `security_events`

---

## 🎯 Common Commands

### Read-Only Mode
```powershell
docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN="token" -e GITHUB_READ_ONLY=1 ghcr.io/github/github-mcp-server
```

### Specific Toolsets
```powershell
docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN="token" -e GITHUB_TOOLSETS="repos,issues,pull_requests" ghcr.io/github/github-mcp-server
```

### Specific Tools Only
```powershell
docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN="token" -e GITHUB_TOOLS="get_file_contents,issue_read" ghcr.io/github/github-mcp-server
```

### Insiders Mode (Beta)
```powershell
docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN="token" -e GITHUB_INSIDERS=true ghcr.io/github/github-mcp-server
```

---

## 🛠️ Available Toolsets

| Toolset | Description |
|---------|-------------|
| `context` | ⭐ User/team context (recommended) |
| `repos` | Repository operations |
| `issues` | Issue management |
| `pull_requests` | PR operations |
| `actions` | GitHub Actions |
| `code_security` | Security scanning |
| `gists` | Gist management |
| `notifications` | Notifications |
| `projects` | GitHub Projects |
| `git` | Low-level Git operations |
| `discussions` | GitHub Discussions |
| `dependabot` | Dependabot alerts |
| `labels` | Label management |
| `orgs` | Organization tools |
| `secret_protection` | Secret scanning |
| `security_advisories` | Security advisories |
| `stargazers` | Star management |
| `users` | User operations |

---

## 💡 Example Use Cases

### Browse Code
```
"Show me the README.md from owner/repo"
Tool: get_file_contents
```

### Create Issue
```
"Create a bug report in owner/repo about login failure"
Tool: issue_write
```

### Search Code
```
"Find all TypeScript files importing React in owner/repo"
Tool: search_code
```

### Monitor Workflows
```
"Show failed GitHub Actions runs in owner/repo"
Tool: actions_list
```

### Security Check
```
"List all Dependabot alerts in owner/repo"
Tool: list_dependabot_alerts
```

---

## 🔐 Security Checklist

- [ ] Token stored in environment variable (not hardcoded)
- [ ] `.env.mcp` added to `.gitignore`
- [ ] Minimal scopes granted
- [ ] Token rotation scheduled (90 days)
- [ ] Read-only mode for safe operations

---

## 🐛 Troubleshooting

### Can't Pull Image
```powershell
docker logout ghcr.io
docker pull ghcr.io/github/github-mcp-server
```

### Authentication Failed
```powershell
# Test token
curl -H "Authorization: token ghp_token" https://api.github.com/user
```

### Rate Limited
- Authenticated: 5,000 req/hour
- Wait for reset or use different token

---

## 📁 VS Code Integration

**File:** `.vscode/mcp.json` (already created)

**Usage:**
1. Open VS Code 1.101+
2. Toggle Agent mode in Copilot Chat
3. Server starts automatically
4. Ask questions naturally

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| `GITHUB_MCP_QUICKSTART.md` | 15-min quick start |
| `GITHUB_MCP_SETUP_GUIDE.md` | Complete setup |
| `GITHUB_MCP_INTEGRATION_PLAN.md` | Integration details |
| `GITHUB_MCP_INTEGRATION_COMPLETE.md` | Summary |
| `GITHUB_MCP_QUICK_REFERENCE.md` | This file |

---

## 🔗 Quick Links

- **Token Creation**: https://github.com/settings/tokens/new
- **Official Repo**: https://github.com/github/github-mcp-server
- **MCP Protocol**: https://modelcontextprotocol.io
- **VS Code Docs**: https://code.visualstudio.com/docs/copilot/chat/mcp-servers

---

## ⚙️ Environment Variables

```env
# .env.mcp (add to .gitignore!)
GITHUB_PERSONAL_ACCESS_TOKEN=ghp_your_token_here
GITHUB_TOOLSETS=repos,issues,pull_requests
GITHUB_READ_ONLY=0
GITHUB_INSIDERS=false
GITHUB_HOST=https://github.com
```

---

## 🎯 Top 10 Most Useful Tools

1. `get_file_contents` - Read files
2. `search_code` - Search code
3. `issue_read` - Get issue details
4. `issue_write` - Create/update issues
5. `pull_request_read` - Get PR details
6. `create_pull_request` - Create PRs
7. `list_issues` - List issues
8. `actions_list` - List workflows
9. `get_job_logs` - Get workflow logs
10. `search_repositories` - Search repos

---

## 📊 Rate Limits

| Type | Limit |
|------|-------|
| Authenticated | 5,000/hour |
| Unauthenticated | 60/hour |
| Search API | 30/minute |
| GraphQL | 5,000 points/hour |

---

## ✅ Quick Verification

```powershell
# Test server
docker run -it --rm ghcr.io/github/github-mcp-server tool-search "issue"

# Expected: List of issue-related tools
```

---

**Need more details?** See `GITHUB_MCP_SETUP_GUIDE.md`

**Ready to start?** Follow `GITHUB_MCP_QUICKSTART.md`

---

*Last Updated: January 2026*  
*Version: 1.0*
