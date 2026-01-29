# 📚 API Documentation

**Version**: 1.0.0  
**Last Updated**: January 28, 2026  
**Base URLs**:
- Java Backend: `http://localhost:8000`
- Python Backend: `http://127.0.0.1:8000`

---

## 🎯 Overview

This API provides integration with Plaid for financial data access, including account information, transactions, balances, and investment data.

### Available Backends
- **Java Backend** (Port 8000) - Primary backend with full Plaid integration
- **Python Backend** (Port 8000) - Alternative backend with Plaid SDK v14.0.0

---

## 🔐 Authentication

### Plaid Credentials
All endpoints require valid Plaid API credentials configured in the `.env` file:

```env
PLAID_CLIENT_ID=your_client_id
PLAID_SECRET=your_secret
PLAID_ENV=sandbox
```

### Access Tokens
Most data retrieval endpoints require an access token obtained through the Plaid Link flow.

---

## 📋 Endpoints

### 1. Get API Info

**Endpoint**: `POST /api/info`  
**Description**: Returns current API configuration and status  
**Authentication**: None required

#### Request
```bash
curl -X POST http://localhost:8000/api/info
```

#### Response (200 OK)
```json
{
  "access_token": null,
  "item_id": null,
  "products": ["auth", "transactions", "signal"]
}
```

#### Response Fields
| Field | Type | Description |
|-------|------|-------------|
| access_token | string\|null | Current Plaid access token (null if not set) |
| item_id | string\|null | Plaid item ID (null if not set) |
| products | array | List of enabled Plaid products |

---

### 2. Create Link Token

**Endpoint**: `POST /api/create_link_token`  
**Description**: Creates a Plaid Link token for initializing Plaid Link  
**Authentication**: Plaid credentials required

#### Request
```bash
curl -X POST http://localhost:8000/api/create_link_token \
  -H "Content-Type: application/json"
```

#### Response (200 OK)
```json
{
  "expiration": "2026-01-29T03:37:01Z",
  "link_token": "link-sandbox-980d8e99-c234-44ca-96f1-b69aa4e1a7d8",
  "request_id": "ayDzB8PqsiH384o"
}
```

#### Response Fields
| Field | Type | Description |
|-------|------|-------------|
| expiration | string | ISO 8601 timestamp when token expires (24 hours) |
| link_token | string | Token to initialize Plaid Link |
| request_id | string | Plaid request ID for debugging |

#### Error Responses
- **500 Internal Server Error**: Invalid Plaid credentials or API error

---

### 3. Exchange Public Token

**Endpoint**: `POST /api/set_access_token`  
**Description**: Exchanges a public token for an access token  
**Authentication**: Plaid credentials required

#### Request
```bash
curl -X POST http://localhost:8000/api/set_access_token \
  -H "Content-Type: application/json" \
  -d '{"public_token": "public-sandbox-xxxxx"}'
```

#### Request Body
```json
{
  "public_token": "public-sandbox-xxxxx"
}
```

#### Response (200 OK)
```json
{
  "access_token": "access-sandbox-xxxxx",
  "item_id": "item-xxxxx"
}
```

#### Response Fields
| Field | Type | Description |
|-------|------|-------------|
| access_token | string | Plaid access token for API calls |
| item_id | string | Plaid item identifier |

---

### 4. Get Accounts

**Endpoint**: `GET /api/accounts`  
**Description**: Retrieves account information  
**Authentication**: Access token required

#### Request
```bash
curl -X GET http://localhost:8000/api/accounts
```

#### Response (200 OK)
```json
{
  "accounts": [
    {
      "account_id": "xxxxx",
      "balances": {
        "available": 100.00,
        "current": 110.00,
        "limit": null,
        "iso_currency_code": "USD"
      },
      "mask": "0000",
      "name": "Plaid Checking",
      "official_name": "Plaid Gold Standard 0% Interest Checking",
      "subtype": "checking",
      "type": "depository"
    }
  ],
  "item": {
    "item_id": "xxxxx",
    "institution_id": "ins_xxxxx"
  }
}
```

#### Response (204 No Content)
No access token configured

#### Error Responses
- **500 Internal Server Error**: Invalid access token or API error

---

### 5. Get Balance

**Endpoint**: `GET /api/balance`  
**Description**: Retrieves real-time balance information  
**Authentication**: Access token required

#### Request
```bash
curl -X GET http://localhost:8000/api/balance
```

#### Response (200 OK)
```json
{
  "accounts": [
    {
      "account_id": "xxxxx",
      "balances": {
        "available": 100.00,
        "current": 110.00,
        "limit": null,
        "iso_currency_code": "USD"
      },
      "mask": "0000",
      "name": "Plaid Checking",
      "official_name": "Plaid Gold Standard 0% Interest Checking",
      "subtype": "checking",
      "type": "depository"
    }
  ]
}
```

#### Response (204 No Content)
No access token configured

---

### 6. Get Transactions

**Endpoint**: `GET /api/transactions`  
**Description**: Retrieves transaction history  
**Authentication**: Access token required

#### Request
```bash
curl -X GET http://localhost:8000/api/transactions
```

#### Query Parameters
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| start_date | string | No | Start date (YYYY-MM-DD), defaults to 30 days ago |
| end_date | string | No | End date (YYYY-MM-DD), defaults to today |

#### Response (200 OK)
```json
{
  "accounts": [...],
  "transactions": [
    {
      "account_id": "xxxxx",
      "amount": 12.74,
      "iso_currency_code": "USD",
      "category": ["Food and Drink", "Restaurants"],
      "date": "2026-01-28",
      "name": "McDonald's",
      "pending": false,
      "transaction_id": "xxxxx",
      "transaction_type": "place"
    }
  ],
  "total_transactions": 100
}
```

#### Response (204 No Content)
No access token configured

---

### 7. Get Auth Data

**Endpoint**: `GET /api/auth`  
**Description**: Retrieves account and routing numbers  
**Authentication**: Access token required

#### Request
```bash
curl -X GET http://localhost:8000/api/auth
```

#### Response (200 OK)
```json
{
  "accounts": [...],
  "numbers": {
    "ach": [
      {
        "account": "9900009606",
        "account_id": "xxxxx",
        "routing": "011401533",
        "wire_routing": "021000021"
      }
    ]
  }
}
```

---

### 8. Get Identity

**Endpoint**: `GET /api/identity`  
**Description**: Retrieves identity information  
**Authentication**: Access token required

#### Request
```bash
curl -X GET http://localhost:8000/api/identity
```

#### Response (200 OK)
```json
{
  "accounts": [...],
  "identity": {
    "addresses": [...],
    "emails": [...],
    "names": [...],
    "phone_numbers": [...]
  }
}
```

---

### 9. Get Holdings

**Endpoint**: `GET /api/holdings`  
**Description**: Retrieves investment holdings  
**Authentication**: Access token required

#### Request
```bash
curl -X GET http://localhost:8000/api/holdings
```

#### Response (200 OK)
```json
{
  "accounts": [...],
  "holdings": [
    {
      "account_id": "xxxxx",
      "security_id": "xxxxx",
      "institution_price": 1.00,
      "institution_value": 100.00,
      "quantity": 100,
      "iso_currency_code": "USD"
    }
  ],
  "securities": [...]
}
```

---

### 10. Get Investment Transactions

**Endpoint**: `GET /api/investments_transactions`  
**Description**: Retrieves investment transaction history  
**Authentication**: Access token required

#### Request
```bash
curl -X GET http://localhost:8000/api/investments_transactions
```

#### Response (200 OK)
```json
{
  "accounts": [...],
  "investment_transactions": [
    {
      "account_id": "xxxxx",
      "amount": 100.00,
      "date": "2026-01-28",
      "name": "Buy",
      "quantity": 10,
      "security_id": "xxxxx",
      "type": "buy"
    }
  ],
  "securities": [...]
}
```

---

## 🔄 Common Workflows

### Complete Plaid Link Flow

1. **Create Link Token**
   ```bash
   curl -X POST http://localhost:8000/api/create_link_token
   ```

2. **Initialize Plaid Link** (Frontend)
   - Use link_token to initialize Plaid Link
   - User selects institution and authenticates
   - Receive public_token on success

3. **Exchange Public Token**
   ```bash
   curl -X POST http://localhost:8000/api/set_access_token \
     -H "Content-Type: application/json" \
     -d '{"public_token": "public-sandbox-xxxxx"}'
   ```

4. **Retrieve Data**
   ```bash
   # Get accounts
   curl -X GET http://localhost:8000/api/accounts
   
   # Get transactions
   curl -X GET http://localhost:8000/api/transactions
   
   # Get balance
   curl -X GET http://localhost:8000/api/balance
   ```

---

## ⚠️ Error Handling

### HTTP Status Codes

| Code | Description | Common Causes |
|------|-------------|---------------|
| 200 | Success | Request completed successfully |
| 204 | No Content | No access token configured |
| 400 | Bad Request | Invalid request parameters |
| 404 | Not Found | Endpoint does not exist |
| 405 | Method Not Allowed | Wrong HTTP method used |
| 500 | Internal Server Error | Plaid API error, invalid credentials, or server error |

### Error Response Format

```json
{
  "code": 500,
  "message": "HTTP 500 Internal Server Error"
}
```

---

## 🧪 Testing

### Sandbox Credentials

For testing in Plaid sandbox environment:

**Username**: `user_good`  
**Password**: `pass_good`  
**Institution**: Any sandbox institution (e.g., "Platypus")

### Test Scripts

```powershell
# Test all endpoints
.\test-all-endpoints.ps1

# Test Plaid API directly
.\test-plaid-direct.ps1

# Run complete test suite
.\run-complete-test-suite.ps1
```

---

## 📊 Rate Limits

### Plaid API Limits (Sandbox)
- **Link Token Creation**: Unlimited
- **Data Retrieval**: Unlimited
- **Token Exchange**: Unlimited

### Production Limits
Refer to Plaid documentation for production rate limits.

---

## 🔒 Security Best Practices

1. **Never expose credentials** in client-side code
2. **Use HTTPS** in production
3. **Implement rate limiting** on your endpoints
4. **Validate all inputs** before processing
5. **Log all API calls** for audit purposes
6. **Rotate secrets** regularly
7. **Use environment variables** for sensitive data

---

## 📝 Notes

### Python Backend Differences
- Uses plaid-python v14.0.0
- Some features not available (CRA, newer API features)
- Compatible with core Plaid functionality
- See PYTHON_SDK_V14_COMPATIBILITY_NOTE.md for details

### Java Backend Features
- Full Plaid API support
- Latest SDK version
- All products available

---

## 🆘 Troubleshooting

### Common Issues

**Issue**: HTTP 500 on data retrieval endpoints  
**Solution**: Ensure access token is set via `/api/set_access_token`

**Issue**: HTTP 204 No Content  
**Solution**: Complete Plaid Link flow to obtain access token

**Issue**: Invalid credentials error  
**Solution**: Verify PLAID_CLIENT_ID and PLAID_SECRET in .env file

**Issue**: Link token expired  
**Solution**: Link tokens expire after 24 hours, create a new one

---

## 📚 Additional Resources

- **Plaid API Documentation**: https://plaid.com/docs/api/
- **Plaid Quickstart**: https://github.com/plaid/quickstart
- **Manual Testing Guide**: MANUAL_INTEGRATION_TEST_GUIDE.md
- **Testing Results**: THOROUGH_TESTING_RESULTS.md

---

**Last Updated**: January 28, 2026  
**API Version**: 1.0.0  
**Status**: Production Ready ✅
