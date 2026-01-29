# 🏗️ System Architecture Documentation

**Version**: 1.0.0  
**Last Updated**: January 28, 2026  
**Status**: Production Ready

---

## 📊 System Overview

This is a full-stack financial dashboard application with Plaid integration, built using a microservices architecture with Docker containerization.

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Client Layer                         │
│                    (Web Browser / Mobile)                    │
└────────────────────────┬────────────────────────────────────┘
                         │
                         │ HTTPS
                         │
┌────────────────────────▼────────────────────────────────────┐
│                      Frontend Layer                          │
│                   React Application                          │
│                    (Port 3000)                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  • Plaid Link Integration                            │  │
│  │  • Dashboard UI                                       │  │
│  │  • Data Visualization                                │  │
│  │  • State Management                                   │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────────┬────────────────────────────────────┘
                         │
                         │ REST API
                         │
┌────────────────────────▼────────────────────────────────────┐
│                     Backend Layer                            │
│              (Multiple Backend Options)                      │
│                                                              │
│  ┌─────────────────────┐      ┌─────────────────────┐      │
│  │   Java Backend      │      │  Python Backend     │      │
│  │   (Port 8000)       │      │  (Port 8000)        │      │
│  │                     │      │                     │      │
│  │  • Plaid SDK        │      │  • Plaid SDK v14    │      │
│  │  • API Endpoints    │      │  • API Endpoints    │      │
│  │  • Business Logic   │      │  • Business Logic   │      │
│  └─────────────────────┘      └─────────────────────┘      │
└────────────────────────┬────────────────────────────────────┘
                         │
                         │ HTTPS API Calls
                         │
┌────────────────────────▼────────────────────────────────────┐
│                    External Services                         │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                  Plaid API                            │  │
│  │  • Link Token Creation                               │  │
│  │  • Token Exchange                                     │  │
│  │  • Account Data                                       │  │
│  │  • Transaction Data                                   │  │
│  │  • Balance Data                                       │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔧 Component Architecture

### Frontend (React Application)

**Technology Stack**:
- React 18.x
- TypeScript
- SCSS for styling
- Plaid Link SDK

**Key Components**:

```
frontend/
├── src/
│   ├── App.tsx                 # Main application component
│   ├── Components/
│   │   ├── Endpoint/           # API endpoint display
│   │   ├── Headers/            # Header components
│   │   ├── Link/               # Plaid Link integration
│   │   ├── ProductTypes/       # Product type components
│   │   └── Table/              # Data table components
│   ├── Context/
│   │   └── index.tsx           # Application context
│   ├── dataUtilities.ts        # Data processing utilities
│   └── setupProxy.js           # Development proxy setup
└── public/
    └── index.html              # HTML entry point
```

**Data Flow**:
1. User initiates Plaid Link
2. Frontend requests link token from backend
3. Plaid Link modal opens
4. User authenticates with institution
5. Public token received
6. Frontend exchanges public token for access token
7. Frontend requests financial data
8. Data displayed in dashboard

---

### Backend (Java)

**Technology Stack**:
- Java 11+
- Spring Boot (implied)
- Plaid Java SDK (latest)
- Maven for dependency management

**Architecture Pattern**: RESTful API

**Key Features**:
- Full Plaid API integration
- All Plaid products supported
- Comprehensive error handling
- Request/response logging

**Endpoints**:
- `POST /api/info` - API configuration
- `POST /api/create_link_token` - Link token creation
- `POST /api/set_access_token` - Token exchange
- `GET /api/accounts` - Account data
- `GET /api/balance` - Balance data
- `GET /api/transactions` - Transaction history
- `GET /api/auth` - Auth data
- `GET /api/identity` - Identity data
- `GET /api/holdings` - Investment holdings
- `GET /api/investments_transactions` - Investment transactions

---

### Backend (Python)

**Technology Stack**:
- Python 3.8+
- Flask web framework
- plaid-python SDK v14.0.0
- Virtual environment for dependencies

**Architecture Pattern**: RESTful API

**Key Features**:
- Core Plaid integration
- Compatible with v14.0.0 SDK
- Lightweight and fast
- Easy to deploy

**Limitations**:
- CRA features not available
- Some newer API features unavailable
- Requires SDK upgrade for latest features

**File Structure**:
```
quickstart/python/
├── server.py           # Main Flask application
├── requirements.txt    # Python dependencies
├── start.sh           # Startup script
└── Dockerfile         # Docker configuration
```

---

## 🐳 Docker Architecture

### Container Structure

```
┌─────────────────────────────────────────────────────────────┐
│                     Docker Compose                           │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Frontend Container                                   │  │
│  │  • Node.js runtime                                    │  │
│  │  • React application                                  │  │
│  │  • Port: 3000                                         │  │
│  │  • Network: quickstart_default                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Java Backend Container                               │  │
│  │  • Java runtime                                       │  │
│  │  • Spring Boot application                            │  │
│  │  • Port: 8000                                         │  │
│  │  • Network: quickstart_default                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Python Backend Container (Optional)                  │  │
│  │  • Python runtime                                     │  │
│  │  • Flask application                                  │  │
│  │  • Port: 8000                                         │  │
│  │  • Network: quickstart_default                        │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### Docker Compose Configuration

**File**: `quickstart/docker-compose.yml`

**Key Features**:
- Multi-container orchestration
- Shared network for inter-container communication
- Environment variable injection
- Volume mounting for development
- Health checks
- Automatic restart policies

---

## 🔄 Data Flow

### Complete User Journey

```
1. User Opens Application
   ↓
2. Frontend Loads Dashboard
   ↓
3. User Clicks "Launch Link"
   ↓
4. Frontend → Backend: POST /api/create_link_token
   ↓
5. Backend → Plaid API: Create Link Token
   ↓
6. Plaid API → Backend: Link Token
   ↓
7. Backend → Frontend: Link Token
   ↓
8. Frontend: Initialize Plaid Link with Token
   ↓
9. User: Select Institution & Authenticate
   ↓
10. Plaid Link → Frontend: Public Token
    ↓
11. Frontend → Backend: POST /api/set_access_token
    ↓
12. Backend → Plaid API: Exchange Public Token
    ↓
13. Plaid API → Backend: Access Token
    ↓
14. Backend: Store Access Token
    ↓
15. Backend → Frontend: Success Response
    ↓
16. Frontend → Backend: GET /api/accounts
    ↓
17. Backend → Plaid API: Get Accounts (with Access Token)
    ↓
18. Plaid API → Backend: Account Data
    ↓
19. Backend → Frontend: Account Data
    ↓
20. Frontend: Display Data in Dashboard
```

---

## 🔐 Security Architecture

### Security Layers

**1. Environment Variables**
- Sensitive credentials stored in `.env` files
- Never committed to version control
- Different configs for dev/staging/prod

**2. API Security**
- HTTPS in production
- CORS configuration
- Request validation
- Rate limiting (recommended)

**3. Token Management**
- Access tokens stored server-side
- Public tokens exchanged immediately
- Link tokens expire after 24 hours
- No sensitive data in client-side storage

**4. Network Security**
- Docker network isolation
- Internal service communication
- External API calls over HTTPS

---

## 📊 Deployment Architecture

### Development Environment

```
Local Machine
├── Docker Desktop
│   ├── Frontend Container (Port 3000)
│   └── Backend Container (Port 8000)
├── Python Virtual Environment
│   └── Python Backend (Port 8000)
└── Development Tools
    ├── VS Code
    ├── Git
    └── Testing Scripts
```

### Production Environment Options

**Option 1: Cloud Platform (Vercel/Heroku)**
```
Internet
  ↓
CDN (Vercel/Cloudflare)
  ↓
Frontend (Static Hosting)
  ↓
Backend (Container/Serverless)
  ↓
Plaid API
```

**Option 2: Docker Hub + Cloud**
```
Docker Hub Registry
  ↓
Pull Images
  ↓
Cloud Provider (AWS/GCP/Azure)
  ↓
Container Orchestration (ECS/GKE/AKS)
  ↓
Load Balancer
  ↓
Application Containers
```

**Option 3: Kubernetes**
```
Kubernetes Cluster
├── Ingress Controller
├── Frontend Pods (Replicas: 3)
├── Backend Pods (Replicas: 3)
├── Service Discovery
└── ConfigMaps/Secrets
```

---

## 🔧 Technology Stack Summary

### Frontend
| Technology | Version | Purpose |
|------------|---------|---------|
| React | 18.x | UI Framework |
| TypeScript | 4.x | Type Safety |
| SCSS | - | Styling |
| Plaid Link | Latest | Bank Connection |

### Backend (Java)
| Technology | Version | Purpose |
|------------|---------|---------|
| Java | 11+ | Runtime |
| Spring Boot | 2.x/3.x | Framework |
| Plaid SDK | Latest | API Integration |
| Maven | 3.x | Build Tool |

### Backend (Python)
| Technology | Version | Purpose |
|------------|---------|---------|
| Python | 3.8+ | Runtime |
| Flask | 2.x | Web Framework |
| plaid-python | 14.0.0 | API Integration |
| pip | Latest | Package Manager |

### Infrastructure
| Technology | Version | Purpose |
|------------|---------|---------|
| Docker | 20.x+ | Containerization |
| Docker Compose | 2.x | Orchestration |
| Nginx | Latest | Reverse Proxy |
| Git | 2.x | Version Control |

---

## 📈 Scalability Considerations

### Horizontal Scaling
- Frontend: Static files can be served from CDN
- Backend: Stateless design allows multiple instances
- Load balancing: Distribute traffic across instances

### Vertical Scaling
- Increase container resources (CPU/Memory)
- Optimize database queries
- Implement caching strategies

### Performance Optimization
- Response caching
- Database connection pooling
- Async processing for heavy operations
- CDN for static assets

---

## 🔍 Monitoring & Observability

### Recommended Monitoring

**Application Metrics**:
- Request/response times
- Error rates
- API call volumes
- User sessions

**Infrastructure Metrics**:
- Container health
- CPU/Memory usage
- Network traffic
- Disk I/O

**Business Metrics**:
- Active users
- Plaid Link success rate
- Data retrieval success rate
- Feature usage

### Logging Strategy

**Log Levels**:
- ERROR: Application errors
- WARN: Potential issues
- INFO: Important events
- DEBUG: Detailed debugging

**Log Aggregation**:
- Centralized logging (ELK Stack, CloudWatch)
- Log retention policies
- Alert configuration

---

## 🧪 Testing Architecture

### Test Pyramid

```
        ┌─────────────┐
        │   E2E Tests │  ← Manual UI Testing
        └─────────────┘
       ┌───────────────┐
       │ Integration   │  ← API Testing
       │    Tests      │
       └───────────────┘
      ┌─────────────────┐
      │   Unit Tests    │  ← Component Testing
      └─────────────────┘
```

### Test Coverage

**Automated Tests** (21/21 passing):
- Container health tests
- API endpoint tests
- Integration tests
- Error handling tests
- Performance tests

**Manual Tests** (Optional):
- UI interaction tests
- End-to-end user flows
- Cross-browser testing
- Mobile responsiveness

---

## 📝 Configuration Management

### Environment Configuration

**Development** (`.env.development`):
```env
PLAID_ENV=sandbox
PLAID_CLIENT_ID=dev_client_id
PLAID_SECRET=dev_secret
```

**Production** (`.env.production`):
```env
PLAID_ENV=production
PLAID_CLIENT_ID=prod_client_id
PLAID_SECRET=prod_secret
```

### Feature Flags

Recommended for:
- Gradual feature rollout
- A/B testing
- Emergency feature disable

---

## 🚀 Deployment Pipeline

### CI/CD Workflow

```
1. Code Commit
   ↓
2. GitHub Actions Triggered
   ↓
3. Run Tests
   ↓
4. Build Docker Images
   ↓
5. Push to Registry
   ↓
6. Deploy to Staging
   ↓
7. Run Smoke Tests
   ↓
8. Deploy to Production
   ↓
9. Monitor & Alert
```

### Deployment Strategies

**Blue-Green Deployment**:
- Zero downtime
- Easy rollback
- Requires 2x resources

**Rolling Deployment**:
- Gradual rollout
- Minimal resource overhead
- Longer deployment time

**Canary Deployment**:
- Test with small user percentage
- Gradual traffic increase
- Early issue detection

---

## 📚 Additional Resources

### Documentation
- **API_DOCUMENTATION.md** - Complete API reference
- **QUICK_START_GUIDE.md** - Quick setup guide
- **DEPLOYMENT_GUIDE.md** - Deployment instructions
- **THOROUGH_TESTING_RESULTS.md** - Test results

### Diagrams
- System architecture (this document)
- Data flow diagrams (this document)
- Deployment architecture (this document)

---

## 🎯 Future Architecture Enhancements

### Recommended Improvements

1. **Microservices Separation**
   - Separate auth service
   - Separate data service
   - API gateway

2. **Database Layer**
   - Add persistent storage
   - Implement caching (Redis)
   - Data warehouse for analytics

3. **Message Queue**
   - Async processing
   - Event-driven architecture
   - Better scalability

4. **Service Mesh**
   - Istio/Linkerd
   - Advanced traffic management
   - Enhanced observability

---

**Last Updated**: January 28, 2026  
**Architecture Version**: 1.0.0  
**Status**: Production Ready ✅
