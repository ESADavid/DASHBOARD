# Plaid Payroll - Quick Start Guide

## 🚀 Get Started in 5 Minutes

This guide will help you quickly test the new Plaid Payroll integration.

## Prerequisites

- Plaid account with Employment product enabled
- Node.js or Python installed
- Valid Plaid API credentials

## Step 1: Configure Environment

Create or update your `.env` file in the `quickstart/node` or `quickstart/python` directory:

```bash
# Plaid API Credentials
PLAID_CLIENT_ID=your_client_id_here
PLAID_SECRET=your_secret_here
PLAID_ENV=sandbox

# Add payroll and employment to products
PLAID_PRODUCTS=transactions,auth,identity,payroll,employment

# Country codes
PLAID_COUNTRY_CODES=US
```

## Step 2: Start the Backend Server

### Option A: Node.js
```bash
cd quickstart/node
npm install
npm start
```

### Option B: Python
```bash
cd quickstart/python
pip install -r requirements.txt
python server.py
```

Server will start on `http://localhost:8000`

## Step 3: Start the Frontend

```bash
cd quickstart/frontend
npm install
npm start
```

Frontend will start on `http://localhost:3000`

## Step 4: Link a Payroll Provider

1. Open `http://localhost:3000` in your browser
2. Click "Launch Link" button
3. Search for a payroll provider (e.g., "Gusto", "ADP")
4. Use Sandbox credentials:
   - Username: `user_good`
   - Password: `pass_good`
5. Complete the Link flow

## Step 5: View Payroll Data

Once linked, you'll see two new sections in the dashboard:

### 📊 Payroll Section
Displays:
- Employer name
- Pay period dates
- Pay dates
- Gross pay amounts
- Net pay amounts

### 💼 Employment Section
Displays:
- Employer name
- Job title
- Start date
- End date (if applicable)
- Employment status

## Testing with PowerShell

Run the automated test script:

```powershell
.\test-payroll-endpoints.ps1
```

This will test both endpoints and display results.

## API Endpoints

### Get Payroll Data
```bash
GET http://localhost:8000/api/payroll
```

**Response:**
```json
{
  "error": null,
  "payroll": {
    "employments": [
      {
        "employer": { "name": "Acme Corp" },
        "pay_stubs": [...]
      }
    ]
  }
}
```

### Get Employment Data
```bash
GET http://localhost:8000/api/employment
```

**Response:**
```json
{
  "error": null,
  "employment": {
    "employments": [
      {
        "employer": { "name": "Acme Corp" },
        "title": "Software Engineer",
        "start_date": "2020-01-15",
        "employment_status": "ACTIVE"
      }
    ]
  }
}
```

## Sandbox Test Institutions

In Plaid Sandbox, you can test with these payroll providers:

1. **Gusto** - Full payroll data support
2. **ADP** - Employment and payroll data
3. **Paychex** - Payroll processing data
4. **QuickBooks Payroll** - Small business payroll

### Test Credentials
- Username: `user_good` (successful connection)
- Password: `pass_good`

Alternative test scenarios:
- `user_bad` / `pass_bad` - Failed authentication
- `user_custom` / `pass_custom` - Custom test data

## Troubleshooting

### Issue: "PRODUCT_NOT_READY"
**Solution**: Payroll data is still processing. Wait 2-3 seconds and retry.

### Issue: "INVALID_ACCESS_TOKEN"
**Solution**: 
1. Re-link the account through Plaid Link
2. Ensure you've completed the Link flow successfully

### Issue: No data displayed
**Solution**:
1. Check browser console for errors
2. Verify backend is running on port 8000
3. Check that `payroll` and `employment` are in PLAID_PRODUCTS

### Issue: TypeScript errors
**Solution**: The existing TypeScript errors in the project are pre-existing and don't affect payroll functionality.

## Docker Setup

If using Docker:

```yaml
# docker-compose.yml
services:
  backend:
    environment:
      - PLAID_PRODUCTS=transactions,auth,identity,payroll,employment
```

Then run:
```bash
docker-compose up
```

## Next Steps

1. ✅ Test in Sandbox environment
2. ✅ Verify data display in frontend
3. 📝 Configure webhooks for production
4. 🔒 Implement proper access controls
5. 🚀 Deploy to production

## Production Checklist

Before going to production:

- [ ] Enable Employment product in Plaid Dashboard
- [ ] Update to production credentials
- [ ] Configure webhook endpoints
- [ ] Implement data encryption
- [ ] Set up access logging
- [ ] Test with real payroll providers
- [ ] Implement error handling
- [ ] Add rate limiting
- [ ] Configure CORS properly
- [ ] Set up monitoring/alerts

## Support Resources

- **Documentation**: See `PAYROLL_INTEGRATION_GUIDE.md`
- **Plaid Docs**: https://plaid.com/docs/api/products/employment/
- **Plaid Dashboard**: https://dashboard.plaid.com/
- **Support**: https://dashboard.plaid.com/support

## Example Use Cases

### 1. Income Verification
Use payroll data to verify income for:
- Loan applications
- Rental applications
- Credit decisions

### 2. Employment Verification
Verify employment for:
- Background checks
- Mortgage applications
- Government benefits

### 3. Payroll Analytics
Analyze payroll data for:
- Financial planning
- Tax preparation
- Expense tracking

---

**Ready to test?** Run `.\test-payroll-endpoints.ps1` to get started!
