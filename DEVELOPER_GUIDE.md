# 👨‍💻 Developer Guide

**Version**: 1.0.0  
**Last Updated**: January 28, 2026  
**Target Audience**: Developers joining the project

---

## 🎯 Welcome!

This guide will help you get started with the Financial Dashboard project. Whether you're setting up your development environment, making your first contribution, or understanding the codebase, this guide has you covered.

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Quick Setup](#quick-setup)
3. [Project Structure](#project-structure)
4. [Development Workflow](#development-workflow)
5. [Coding Standards](#coding-standards)
6. [Testing Guidelines](#testing-guidelines)
7. [Common Tasks](#common-tasks)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)

---

## 🔧 Prerequisites

### Required Software

| Software | Version | Purpose |
|----------|---------|---------|
| Node.js | 16.x+ | Frontend development |
| Python | 3.8+ | Backend development |
| Java | 11+ | Backend development |
| Docker | 20.x+ | Containerization |
| Git | 2.x+ | Version control |
| VS Code | Latest | Recommended IDE |

### Recommended VS Code Extensions

```json
{
  "recommendations": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "ms-python.python",
    "ms-azuretools.vscode-docker",
    "redhat.vscode-yaml",
    "ms-vscode.powershell"
  ]
}
```

### Accounts Needed

- **Plaid Account**: Sign up at https://dashboard.plaid.com/signup
- **GitHub Account**: For version control
- **Docker Hub** (Optional): For container registry

---

## 🚀 Quick Setup

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/dashboard.git
cd dashboard
```

### 2. Set Up Environment Variables

Create `.env` file in `quickstart/` directory:

```env
PLAID_CLIENT_ID=your_client_id_here
PLAID_SECRET=your_secret_here
PLAID_ENV=sandbox
PLAID_PRODUCTS=auth,transactions,signal
PLAID_COUNTRY_CODES=US,CA
```

### 3. Start with Docker (Recommended)

```powershell
# Start all services
docker compose -f quickstart/docker-compose.yml up -d

# Verify containers are running
docker compose -f quickstart/docker-compose.yml ps
```

### 4. Or Start Manually

**Frontend**:
```bash
cd quickstart/frontend
npm install
npm start
```

**Java Backend**:
```bash
cd quickstart/java
mvn clean install
mvn spring-boot:run
```

**Python Backend**:
```bash
cd quickstart/python
python -m venv .venv
.venv\Scripts\activate  # Windows
source .venv/bin/activate  # Mac/Linux
pip install -r requirements.txt
python server.py
```

### 5. Verify Setup

```powershell
# Run test suite
.\run-complete-test-suite.ps1

# Should see: 21/21 tests passed
```

---

## 📁 Project Structure

```
dashboard/
├── .github/
│   └── workflows/          # CI/CD pipelines
├── docs/                   # Documentation
│   └── corporate/          # Corporate documents
├── public/                 # Static frontend files
│   ├── index.html
│   ├── css/
│   └── js/
├── quickstart/             # Main application code
│   ├── frontend/           # React application
│   │   ├── src/
│   │   │   ├── Components/
│   │   │   ├── Context/
│   │   │   └── App.tsx
│   │   └── package.json
│   ├── java/               # Java backend
│   │   ├── src/
│   │   └── pom.xml
│   ├── python/             # Python backend
│   │   ├── server.py
│   │   └── requirements.txt
│   └── docker-compose.yml
├── API_DOCUMENTATION.md    # API reference
├── ARCHITECTURE.md         # System architecture
├── DEVELOPER_GUIDE.md      # This file
├── QUICK_START_GUIDE.md    # Quick reference
└── README.md               # Project overview
```

---

## 🔄 Development Workflow

### Daily Workflow

1. **Pull Latest Changes**
   ```bash
   git pull origin main
   ```

2. **Create Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Changes**
   - Write code
   - Add tests
   - Update documentation

4. **Test Locally**
   ```powershell
   .\run-complete-test-suite.ps1
   ```

5. **Commit Changes**
   ```bash
   git add .
   git commit -m "feat: add new feature"
   ```

6. **Push and Create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

### Commit Message Convention

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build/tooling changes

**Examples**:
```
feat(api): add balance endpoint
fix(frontend): resolve link token expiration
docs(readme): update setup instructions
test(api): add integration tests for transactions
```

---

## 📝 Coding Standards

### TypeScript/JavaScript (Frontend)

**Style Guide**: Airbnb JavaScript Style Guide

```typescript
// ✅ Good
interface User {
  id: string;
  name: string;
  email: string;
}

const getUser = async (id: string): Promise<User> => {
  const response = await fetch(`/api/users/${id}`);
  return response.json();
};

// ❌ Bad
const getUser = (id) => {
  return fetch('/api/users/' + id).then(r => r.json())
}
```

**Key Rules**:
- Use TypeScript for type safety
- Use async/await over promises
- Use functional components with hooks
- Keep components small and focused
- Use meaningful variable names

### Python (Backend)

**Style Guide**: PEP 8

```python
# ✅ Good
def get_account_balance(access_token: str) -> dict:
    """
    Retrieve account balance from Plaid API.
    
    Args:
        access_token: Plaid access token
        
    Returns:
        dict: Account balance data
    """
    response = client.balance_get(access_token)
    return response.to_dict()

# ❌ Bad
def getBalance(token):
    return client.balance_get(token).to_dict()
```

**Key Rules**:
- Use type hints
- Write docstrings for functions
- Use snake_case for variables/functions
- Keep functions under 50 lines
- Handle exceptions explicitly

### Java (Backend)

**Style Guide**: Google Java Style Guide

```java
// ✅ Good
public class AccountService {
    private final PlaidClient plaidClient;
    
    public AccountService(PlaidClient plaidClient) {
        this.plaidClient = plaidClient;
    }
    
    public AccountsGetResponse getAccounts(String accessToken) 
            throws PlaidException {
        AccountsGetRequest request = new AccountsGetRequest()
            .accessToken(accessToken);
        return plaidClient.accountsGet(request);
    }
}

// ❌ Bad
public class AccountService {
    PlaidClient client;
    public AccountsGetResponse getAccounts(String token) {
        return client.accountsGet(new AccountsGetRequest().accessToken(token));
    }
}
```

**Key Rules**:
- Use dependency injection
- Write Javadoc for public methods
- Use camelCase for variables/methods
- Keep classes focused (Single Responsibility)
- Handle exceptions appropriately

---

## 🧪 Testing Guidelines

### Test Structure

```
tests/
├── unit/           # Unit tests
├── integration/    # Integration tests
└── e2e/           # End-to-end tests
```

### Writing Tests

**Frontend (Jest/React Testing Library)**:
```typescript
import { render, screen } from '@testing-library/react';
import { App } from './App';

describe('App Component', () => {
  it('renders dashboard title', () => {
    render(<App />);
    expect(screen.getByText('Financial Dashboard')).toBeInTheDocument();
  });
  
  it('displays link button', () => {
    render(<App />);
    expect(screen.getByRole('button', { name: /launch link/i }))
      .toBeInTheDocument();
  });
});
```

**Backend (Python - pytest)**:
```python
import pytest
from server import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_api_info(client):
    """Test /api/info endpoint"""
    response = client.post('/api/info')
    assert response.status_code == 200
    data = response.get_json()
    assert 'products' in data
    assert isinstance(data['products'], list)
```

### Running Tests

```powershell
# Run all tests
.\run-complete-test-suite.ps1

# Run specific test categories
.\test-plaid-direct.ps1
.\test-all-endpoints.ps1
.\test-frontend-health.ps1

# Run Python import tests
python test-imports.py
```

### Test Coverage Goals

- **Unit Tests**: 80%+ coverage
- **Integration Tests**: All API endpoints
- **E2E Tests**: Critical user flows

---

## 🛠️ Common Tasks

### Adding a New API Endpoint

1. **Define the endpoint** (Java example):
```java
@PostMapping("/api/new-endpoint")
public ResponseEntity<DataResponse> newEndpoint(
        @RequestBody RequestData request) {
    // Implementation
    return ResponseEntity.ok(response);
}
```

2. **Add tests**:
```java
@Test
public void testNewEndpoint() {
    // Test implementation
}
```

3. **Update documentation**:
- Add to API_DOCUMENTATION.md
- Update ARCHITECTURE.md if needed

4. **Test manually**:
```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/new-endpoint `
  -Method POST -ContentType "application/json" `
  -Body '{"key": "value"}'
```

### Adding a New Frontend Component

1. **Create component file**:
```typescript
// src/Components/NewComponent/index.tsx
import React from 'react';
import styles from './index.module.scss';

interface NewComponentProps {
  data: string;
}

export const NewComponent: React.FC<NewComponentProps> = ({ data }) => {
  return (
    <div className={styles.container}>
      <h2>{data}</h2>
    </div>
  );
};
```

2. **Create styles**:
```scss
// src/Components/NewComponent/index.module.scss
.container {
  padding: 1rem;
  background: #fff;
  border-radius: 8px;
}
```

3. **Add tests**:
```typescript
import { render, screen } from '@testing-library/react';
import { NewComponent } from './index';

describe('NewComponent', () => {
  it('renders data prop', () => {
    render(<NewComponent data="Test Data" />);
    expect(screen.getByText('Test Data')).toBeInTheDocument();
  });
});
```

4. **Use in parent component**:
```typescript
import { NewComponent } from './Components/NewComponent';

// In render:
<NewComponent data={someData} />
```

### Updating Dependencies

**Frontend**:
```bash
cd quickstart/frontend
npm update
npm audit fix
```

**Python**:
```bash
cd quickstart/python
pip list --outdated
pip install --upgrade package-name
pip freeze > requirements.txt
```

**Java**:
```bash
cd quickstart/java
mvn versions:display-dependency-updates
# Update pom.xml manually
mvn clean install
```

### Debugging

**Frontend**:
```typescript
// Use React DevTools
console.log('Debug:', data);
debugger; // Breakpoint
```

**Python**:
```python
# Use pdb
import pdb; pdb.set_trace()

# Or use logging
import logging
logging.debug(f"Debug: {data}")
```

**Java**:
```java
// Use IDE debugger or
System.out.println("Debug: " + data);
logger.debug("Debug: {}", data);
```

---

## 🐛 Troubleshooting

### Common Issues

**Issue**: Docker containers won't start
```powershell
# Solution: Check Docker is running
docker --version

# Restart Docker Desktop
# Then try again
docker compose -f quickstart/docker-compose.yml up -d
```

**Issue**: Port already in use
```powershell
# Solution: Find and kill process
netstat -ano | findstr :8000
taskkill /PID <PID> /F
```

**Issue**: Python import errors
```powershell
# Solution: Reinstall dependencies
cd quickstart/python
pip install -r requirements.txt --force-reinstall
```

**Issue**: Frontend won't compile
```bash
# Solution: Clear cache and reinstall
cd quickstart/frontend
rm -rf node_modules package-lock.json
npm install
```

**Issue**: Plaid API errors
```
# Solution: Check credentials
# Verify .env file has correct values
# Ensure PLAID_ENV matches your credentials (sandbox/development/production)
```

---

## 🤝 Contributing

### Before You Start

1. Check existing issues/PRs
2. Discuss major changes first
3. Follow coding standards
4. Write tests
5. Update documentation

### Pull Request Process

1. **Create PR** with clear description
2. **Link related issues**
3. **Ensure tests pass**
4. **Request review** from team
5. **Address feedback**
6. **Merge** after approval

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No new warnings
```

---

## 📚 Additional Resources

### Documentation
- **API_DOCUMENTATION.md** - Complete API reference
- **ARCHITECTURE.md** - System architecture
- **QUICK_START_GUIDE.md** - Quick reference
- **THOROUGH_TESTING_RESULTS.md** - Test results

### External Resources
- [Plaid API Docs](https://plaid.com/docs/api/)
- [React Documentation](https://react.dev/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [Spring Boot Docs](https://spring.io/projects/spring-boot)

### Getting Help

1. **Check documentation** first
2. **Search existing issues** on GitHub
3. **Ask in team chat** (Slack/Discord)
4. **Create new issue** if needed

---

## 🎓 Learning Path

### For New Developers

**Week 1**: Setup & Familiarization
- Set up development environment
- Run the application locally
- Explore the codebase
- Read all documentation

**Week 2**: Small Contributions
- Fix documentation typos
- Add unit tests
- Improve error messages
- Refactor small functions

**Week 3**: Feature Development
- Pick a small feature
- Implement with tests
- Create pull request
- Respond to feedback

**Week 4+**: Advanced Topics
- Work on larger features
- Optimize performance
- Improve architecture
- Mentor new developers

---

## ✅ Developer Checklist

### Daily
- [ ] Pull latest changes
- [ ] Run tests before committing
- [ ] Write meaningful commit messages
- [ ] Keep PRs small and focused

### Weekly
- [ ] Update dependencies
- [ ] Review open PRs
- [ ] Update documentation
- [ ] Clean up branches

### Monthly
- [ ] Review and update docs
- [ ] Refactor technical debt
- [ ] Update dependencies
- [ ] Performance audit

---

## 🎉 Welcome to the Team!

You're now ready to start contributing to the Financial Dashboard project. Remember:

- **Ask questions** - No question is too small
- **Share knowledge** - Help others learn
- **Write tests** - They save time in the long run
- **Document changes** - Future you will thank you
- **Have fun** - Enjoy building great software!

---

**Last Updated**: January 28, 2026  
**Version**: 1.0.0  
**Maintainers**: Development Team
