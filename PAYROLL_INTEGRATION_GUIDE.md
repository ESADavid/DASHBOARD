# Plaid Payroll Integration Guide

## Overview

This guide covers the complete Plaid Payroll integration that has been added to your dashboard. The integration provides access to employment verification and payroll data through Plaid's Employment API.

## Features Implemented

### 1. **Payroll Data Endpoint**
- **Endpoint**: `/api/payroll`
- **Method**: GET
- **Description**: Retrieves detailed payroll information including pay stubs, earnings, and deductions
- **Data Includes**:
  - Employer name
  - Pay period dates (start, end)
  - Pay date
  - Gross pay amounts
  - Net pay amounts
  - Currency information

### 2. **Employment Verification Endpoint**
- **Endpoint**: `/api/employment`
- **Method**: GET
- **Description**: Retrieves employment verification data
- **Data Includes**:
  - Employer name
  - Job title
  - Employment start date
  - Employment end date (if applicable)
  - Employment status

## Backend Implementation

### Node.js (quickstart/node/index.js)

Two new endpoints have been added:

```javascript
// Retrieve Payroll data
app.get('/api/payroll', function (request, response, next) {
  Promise.resolve()
    .then(async function () {
      const payrollResponse = await client.employmentGet({
        access_token: ACCESS_TOKEN,
      });
      prettyPrintResponse(payrollResponse);
      response.json({ error: null, payroll: payrollResponse.data });
    })
    .catch(next);
});

// Retrieve Employment verification data
app.get('/api/employment', function (request, response, next) {
  Promise.resolve()
    .then(async function () {
      const employmentResponse = await client.employmentGet({
        access_token: ACCESS_TOKEN,
      });
      prettyPrintResponse(employmentResponse);
      response.json({ error: null, employment: employmentResponse.data });
    })
    .catch(next);
});
```

### Python (quickstart/python/server.py)

Equivalent endpoints in Python:

```python
@app.route('/api/payroll', methods=['GET'])
def get_payroll():
    try:
        from plaid.model.employment_get_request import EmploymentGetRequest
        request = EmploymentGetRequest(access_token=access_token)
        response = client.employment_get(request)
        pretty_print_response(response.to_dict())
        return jsonify({'error': None, 'payroll': response.to_dict()})
    except plaid.ApiException as e:
        error_response = format_error(e)
        return jsonify(error_response)

@app.route('/api/employment', methods=['GET'])
def get_employment():
    try:
        from plaid.model.employment_get_request import EmploymentGetRequest
        request = EmploymentGetRequest(access_token=access_token)
        response = client.employment_get(request)
        pretty_print_response(response.to_dict())
        return jsonify({'error': None, 'employment': response.to_dict()})
    except plaid.ApiException as e:
        error_response = format_error(e)
        return jsonify(error_response)
```

## Frontend Implementation

### Data Utilities (quickstart/frontend/src/dataUtilities.ts)

#### Interfaces
```typescript
interface PayrollDataItem {
  employerName: string;
  payPeriodStart: string | null;
  payPeriodEnd: string | null;
  payDate: string | null;
  grossPay: string | null;
  netPay: string | null;
}

interface EmploymentDataItem {
  employerName: string;
  title: string | null;
  startDate: string | null;
  endDate: string | null;
  status: string | null;
}
```

#### Categories
```typescript
export const payrollCategories: Array<Categories> = [
  { title: "Employer", field: "employerName" },
  { title: "Pay Period Start", field: "payPeriodStart" },
  { title: "Pay Period End", field: "payPeriodEnd" },
  { title: "Pay Date", field: "payDate" },
  { title: "Gross Pay", field: "grossPay" },
  { title: "Net Pay", field: "netPay" },
];

export const employmentCategories: Array<Categories> = [
  { title: "Employer", field: "employerName" },
  { title: "Title", field: "title" },
  { title: "Start Date", field: "startDate" },
  { title: "End Date", field: "endDate" },
  { title: "Status", field: "status" },
];
```

#### Transform Functions
- `transformPayrollData()`: Processes payroll API response into display format
- `transformEmploymentData()`: Processes employment API response into display format

### UI Components (quickstart/frontend/src/Components/ProductTypes/Products.tsx)

Two new endpoint components added:

```tsx
{products.includes("payroll") && (
  <Endpoint
    endpoint="payroll"
    name="Payroll"
    categories={payrollCategories}
    schema="/employment/get"
    description="Retrieve payroll information including pay stubs, earnings, and deductions"
    transformData={transformPayrollData}
  />
)}

{products.includes("employment") && (
  <Endpoint
    endpoint="employment"
    name="Employment"
    categories={employmentCategories}
    schema="/employment/get"
    description="Retrieve employment verification data including employer, title, and employment dates"
    transformData={transformEmploymentData}
  />
)}
```

## Configuration

### Environment Variables

To enable Payroll in your application, add it to your `.env` file:

```bash
# Add payroll to your products list
PLAID_PRODUCTS=transactions,auth,identity,payroll,employment

# Or for testing payroll exclusively
PLAID_PRODUCTS=payroll,employment
```

### Docker Compose

Update your `docker-compose.yml` to include payroll products:

```yaml
environment:
  - PLAID_PRODUCTS=transactions,auth,identity,payroll,employment
```

## Usage

### 1. **Enable Payroll Product**
   - Log into your Plaid Dashboard
   - Navigate to your application settings
   - Enable the "Employment" product
   - Configure webhook URLs if needed

### 2. **Link a Payroll Provider**
   - Use Plaid Link to connect to a payroll provider
   - Supported providers include:
     - ADP
     - Gusto
     - Paychex
     - QuickBooks Payroll
     - And many more

### 3. **Retrieve Data**
   - Once linked, call `/api/payroll` to get payroll data
   - Call `/api/employment` to get employment verification data

## API Response Structure

### Payroll Response
```json
{
  "error": null,
  "payroll": {
    "employments": [
      {
        "employer": {
          "name": "Acme Corporation"
        },
        "pay_stubs": [
          {
            "pay_period_details": {
              "pay_period_start_date": "2024-01-01",
              "pay_period_end_date": "2024-01-15",
              "pay_date": "2024-01-20"
            },
            "earnings": {
              "total": {
                "current_amount": 5000.00,
                "iso_currency_code": "USD"
              }
            },
            "net_pay": {
              "current_amount": 3750.00,
              "iso_currency_code": "USD"
            }
          }
        ]
      }
    ]
  }
}
```

### Employment Response
```json
{
  "error": null,
  "employment": {
    "employments": [
      {
        "employer": {
          "name": "Acme Corporation"
        },
        "title": "Software Engineer",
        "start_date": "2020-01-15",
        "end_date": null,
        "employment_status": "ACTIVE"
      }
    ]
  }
}
```

## Testing

### Sandbox Testing

In Plaid's Sandbox environment, you can test with:

1. **Test Credentials**:
   - Username: `user_good`
   - Password: `pass_good`

2. **Test Payroll Providers**:
   - Search for "Gusto" or "ADP" in Link
   - Use sandbox credentials to connect

### Testing Script

Create a test script `test-payroll.ps1`:

```powershell
# Test Payroll Endpoint
Write-Host "Testing Payroll Endpoint..." -ForegroundColor Cyan
$payrollResponse = Invoke-RestMethod -Uri "http://localhost:8000/api/payroll" -Method Get
Write-Host "Payroll Response:" -ForegroundColor Green
$payrollResponse | ConvertTo-Json -Depth 10

# Test Employment Endpoint
Write-Host "`nTesting Employment Endpoint..." -ForegroundColor Cyan
$employmentResponse = Invoke-RestMethod -Uri "http://localhost:8000/api/employment" -Method Get
Write-Host "Employment Response:" -ForegroundColor Green
$employmentResponse | ConvertTo-Json -Depth 10
```

## Troubleshooting

### Common Issues

1. **"PRODUCT_NOT_READY" Error**
   - The payroll data may still be processing
   - Wait a few seconds and retry
   - Check webhook notifications for completion

2. **"INVALID_PRODUCT" Error**
   - Ensure "employment" product is enabled in Plaid Dashboard
   - Verify your API keys have access to the Employment product

3. **No Data Returned**
   - Verify the linked institution supports payroll data
   - Check that the user has granted permission for payroll access
   - Ensure the access token is valid

### Debug Mode

Enable detailed logging:

```javascript
// Node.js
const prettyPrintResponse = (response) => {
  console.log(util.inspect(response.data, { colors: true, depth: 4 }));
};
```

```python
# Python
def pretty_print_response(response):
    print(json.dumps(response, indent=2, sort_keys=True, default=str))
```

## Security Considerations

1. **Access Token Storage**
   - Never expose access tokens to the frontend
   - Store tokens securely in your backend database
   - Use encryption for sensitive payroll data

2. **Data Privacy**
   - Payroll data is highly sensitive
   - Implement proper access controls
   - Follow GDPR/CCPA compliance requirements
   - Log all access to payroll data

3. **Webhook Security**
   - Verify webhook signatures
   - Use HTTPS for webhook endpoints
   - Implement retry logic for failed webhooks

## Production Deployment

### Prerequisites

1. **Plaid Account Setup**
   - Upgrade to Production environment
   - Enable Employment product
   - Configure production credentials

2. **Environment Configuration**
   ```bash
   PLAID_ENV=production
   PLAID_CLIENT_ID=your_production_client_id
   PLAID_SECRET=your_production_secret
   PLAID_PRODUCTS=payroll,employment
   ```

3. **Webhook Configuration**
   - Set up webhook endpoint: `https://yourdomain.com/webhooks/plaid`
   - Configure in Plaid Dashboard
   - Handle `EMPLOYMENT` webhook events

### Deployment Steps

1. Update environment variables
2. Deploy backend with payroll endpoints
3. Deploy frontend with payroll UI components
4. Test with production credentials
5. Monitor webhook events

## API Reference

### Plaid Employment API Documentation
- [Employment Overview](https://plaid.com/docs/api/products/employment/)
- [Employment Get](https://plaid.com/docs/api/products/employment/#employmentget)
- [Webhook Events](https://plaid.com/docs/api/webhooks/#employment-webhooks)

## Support

For issues or questions:
- Plaid Support: https://dashboard.plaid.com/support
- Plaid Community: https://community.plaid.com/
- API Documentation: https://plaid.com/docs/

## Next Steps

1. ✅ Backend endpoints implemented (Node.js & Python)
2. ✅ Frontend data transformers created
3. ✅ UI components added
4. 🔄 Test with Plaid Sandbox
5. 🔄 Configure webhooks
6. 🔄 Deploy to production

---

**Implementation Date**: 2024
**Version**: 1.0.0
**Status**: Ready for Testing
