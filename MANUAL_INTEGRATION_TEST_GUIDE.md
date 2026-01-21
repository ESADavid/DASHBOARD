# Manual Integration Testing Guide - Plaid Quickstart
**Date**: January 21, 2026  
**Testing Phase**: Priority 3 - End-to-End Integration Testing  
**Estimated Time**: 15-30 minutes

---

## 🎯 Testing Objectives

1. ✅ Verify frontend UI loads correctly
2. ✅ Test Plaid Link launch functionality
3. ✅ Complete sandbox account connection
4. ✅ Verify public token exchange
5. ✅ Test data retrieval with connected account
6. ✅ Validate all API endpoints with real data
7. ✅ Confirm UI displays data correctly

---

## 📋 Pre-Testing Checklist

Before starting manual testing, verify:

- [x] Docker containers are running
  ```powershell
  docker compose -f quickstart/docker-compose.yml ps
  ```
  Expected: Frontend (port 3000) and Go backend (port 8000) both "Up"

- [x] Backend API is responding
  ```powershell
  Invoke-WebRequest -Uri http://localhost:8000/api/info -Method POST -UseBasicParsing
  ```
  Expected: 200 OK with products array

- [x] Frontend is accessible
  - URL: http://localhost:3000
  - Expected: Page loads without errors

---

## 🧪 Manual Testing Steps

### Step 1: Access Frontend Application

**Action**: Open browser to http://localhost:3000

**Expected Results**:
- ✅ Page loads successfully
- ✅ No console errors
- ✅ Plaid Quickstart interface visible
- ✅ "Launch Link" button is present and clickable

**Screenshot Checklist**:
- [ ] Page title visible
- [ ] Launch Link button visible
- [ ] No error messages
- [ ] Clean UI layout

---

### Step 2: Launch Plaid Link

**Action**: Click the "Launch Link" button

**Expected Results**:
- ✅ Plaid Link modal opens
- ✅ Institution selection screen appears
- ✅ Search functionality works
- ✅ List of sandbox institutions visible

**Common Sandbox Institutions**:
- First Platypus Bank
- Tartan Bank
- Houndstooth Bank
- Tattersall Federal Credit Union

**Troubleshooting**:
- If modal doesn't open: Check browser console for errors
- If "Invalid link token": Backend may not be responding - check logs

---

### Step 3: Select Institution

**Action**: Select "First Platypus Bank" (or any sandbox institution)

**Expected Results**:
- ✅ Institution selected
- ✅ Login screen appears
- ✅ Username and password fields visible
- ✅ Continue button enabled

---

### Step 4: Enter Sandbox Credentials

**Action**: Enter test credentials

**Sandbox Credentials**:
- **Username**: `user_good`
- **Password**: `pass_good`

**Alternative Test Scenarios**:
- `user_bad` / `pass_good` - Tests error handling
- `user_good` / `pass_bad` - Tests invalid password

**Expected Results**:
- ✅ Credentials accepted
- ✅ Account selection screen appears
- ✅ Multiple accounts visible (checking, savings, etc.)

---

### Step 5: Select Accounts

**Action**: Select one or more accounts to link

**Expected Results**:
- ✅ Accounts are selectable
- ✅ Continue button becomes active
- ✅ Selected accounts highlighted

**Recommended**: Select at least 2 accounts for comprehensive testing

---

### Step 6: Complete Connection

**Action**: Click "Continue" to complete the connection

**Expected Results**:
- ✅ Success message appears
- ✅ Plaid Link modal closes
- ✅ Frontend updates with account data
- ✅ Public token exchanged for access token

**Backend Process** (automatic):
1. Frontend receives public token
2. Sends public token to backend
3. Backend exchanges for access token
4. Access token stored in session

---

### Step 7: Verify Account Data Display

**Action**: Check the frontend UI for displayed data

**Expected Data to Appear**:
- ✅ Account names
- ✅ Account types (checking, savings, etc.)
- ✅ Account balances
- ✅ Available balances
- ✅ Account numbers (masked)

**Data Validation**:
- [ ] All selected accounts appear
- [ ] Balances are realistic (sandbox data)
- [ ] No error messages
- [ ] Data formatted correctly

---

### Step 8: Test Individual Endpoints

Now that an account is connected, test each endpoint manually:

#### 8.1: Test Accounts Endpoint
```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/accounts -Method GET -UseBasicParsing
```

**Expected Response**:
```json
{
  "accounts": [
    {
      "account_id": "...",
      "name": "Plaid Checking",
      "type": "depository",
      "subtype": "checking",
      "balances": {
        "available": 100,
        "current": 110
      }
    }
  ]
}
```

**Validation**:
- [ ] Returns 200 OK
- [ ] Contains accounts array
- [ ] Each account has required fields
- [ ] Balances are present

---

#### 8.2: Test Balance Endpoint
```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/balance -Method GET -UseBasicParsing
```

**Expected Response**:
- ✅ Returns account balances
- ✅ Available and current balances present
- ✅ Currency codes included

**Validation**:
- [ ] Returns 200 OK
- [ ] Balance data matches accounts endpoint
- [ ] No errors

---

#### 8.3: Test Auth Endpoint
```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/auth -Method GET -UseBasicParsing
```

**Expected Response**:
```json
{
  "accounts": [...],
  "numbers": {
    "ach": [
      {
        "account": "9900009606",
        "account_id": "...",
        "routing": "011401533",
        "wire_routing": "021000021"
      }
    ]
  }
}
```

**Validation**:
- [ ] Returns 200 OK
- [ ] Contains routing numbers
- [ ] Contains account numbers
- [ ] Numbers are properly formatted

---

#### 8.4: Test Transactions Endpoint
```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/transactions -Method POST -UseBasicParsing
```

**Expected Response**:
```json
{
  "accounts": [...],
  "transactions": [
    {
      "transaction_id": "...",
      "account_id": "...",
      "amount": 12.34,
      "date": "2026-01-15",
      "name": "Merchant Name",
      "category": ["Food and Drink", "Restaurants"]
    }
  ]
}
```

**Validation**:
- [ ] Returns 200 OK
- [ ] Contains transactions array
- [ ] Transactions have required fields
- [ ] Dates are properly formatted
- [ ] Amounts are numeric

---

#### 8.5: Test Identity Endpoint
```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/identity -Method GET -UseBasicParsing
```

**Expected Response**:
```json
{
  "accounts": [...],
  "identity": {
    "addresses": [...],
    "emails": [...],
    "names": ["Alberta Bobbeth Charleson"],
    "phone_numbers": [...]
  }
}
```

**Validation**:
- [ ] Returns 200 OK
- [ ] Contains identity data
- [ ] Names, addresses, emails present
- [ ] Data properly structured

---

### Step 9: Test Error Scenarios

#### 9.1: Test with Invalid Credentials
**Action**: Launch Link again and use `user_bad` / `pass_good`

**Expected Results**:
- ✅ Error message appears
- ✅ User can retry
- ✅ No crash or hang

#### 9.2: Test Account Disconnection
**Action**: If available, test removing/disconnecting account

**Expected Results**:
- ✅ Account removed successfully
- ✅ UI updates accordingly
- ✅ Subsequent API calls return appropriate errors

---

## 📊 Test Results Template

### Frontend Testing Results

| Test | Status | Notes |
|------|--------|-------|
| Page loads | ⬜ | |
| Launch Link button works | ⬜ | |
| Plaid Link modal opens | ⬜ | |
| Institution selection | ⬜ | |
| Credential entry | ⬜ | |
| Account selection | ⬜ | |
| Connection completion | ⬜ | |
| Data display | ⬜ | |

### API Endpoint Testing Results (With Connected Account)

| Endpoint | Status | Response Time | Notes |
|----------|--------|---------------|-------|
| `/api/accounts` | ⬜ | | |
| `/api/balance` | ⬜ | | |
| `/api/auth` | ⬜ | | |
| `/api/transactions` | ⬜ | | |
| `/api/identity` | ⬜ | | |
| `/api/holdings` | ⬜ | | |
| `/api/investments_transactions` | ⬜ | | |

### Error Handling Results

| Scenario | Status | Notes |
|----------|--------|-------|
| Invalid credentials | ⬜ | |
| Network error | ⬜ | |
| Account disconnection | ⬜ | |

---

## 🐛 Common Issues & Solutions

### Issue: Link Token Expired
**Symptoms**: "Link token has expired" error  
**Solution**: Refresh the page to generate a new link token

### Issue: Modal Won't Open
**Symptoms**: Clicking Launch Link does nothing  
**Solution**: 
1. Check browser console for errors
2. Verify backend is running: `docker compose -f quickstart/docker-compose.yml ps`
3. Check backend logs: `docker compose -f quickstart/docker-compose.yml logs go`

### Issue: No Data Appears After Connection
**Symptoms**: Connection succeeds but no data displays  
**Solution**:
1. Check browser console for errors
2. Verify access token was stored
3. Test endpoints manually to confirm data is available
4. Check frontend logs: `docker compose -f quickstart/docker-compose.yml logs frontend`

### Issue: API Returns 400/500 Errors
**Symptoms**: Endpoints return error responses  
**Solution**:
1. Verify account is still connected
2. Check if access token is valid
3. Review backend logs for detailed error messages
4. Ensure .env file has correct credentials

---

## ✅ Success Criteria

Manual integration testing is considered successful when:

- ✅ Frontend loads without errors
- ✅ Plaid Link launches successfully
- ✅ Can connect sandbox account
- ✅ Public token exchange works
- ✅ Access token stored correctly
- ✅ All API endpoints return data (not errors)
- ✅ Data displays correctly in UI
- ✅ Error scenarios handled gracefully
- ✅ No console errors or warnings
- ✅ Performance is acceptable (< 2s response times)

---

## 📝 Post-Testing Actions

After completing manual testing:

1. **Document Results**
   - Fill in the test results template above
   - Note any issues or unexpected behavior
   - Capture screenshots of successful flows

2. **Update Test Reports**
   - Add results to PLAID_INTEGRATION_TEST_RESULTS.md
   - Update THOROUGH_TESTING_COMPLETE.md

3. **Report Issues**
   - Document any bugs found
   - Include steps to reproduce
   - Note severity and impact

4. **Next Steps**
   - If all tests pass: Mark integration testing complete
   - If issues found: Create action items for fixes
   - Consider additional test scenarios

---

## 🎓 Testing Tips

1. **Use Browser DevTools**
   - Keep console open to catch errors
   - Monitor Network tab for API calls
   - Check Application tab for stored data

2. **Test Multiple Scenarios**
   - Try different institutions
   - Test with different account types
   - Verify error handling

3. **Document Everything**
   - Take screenshots of each step
   - Note response times
   - Record any unusual behavior

4. **Be Thorough**
   - Don't skip steps
   - Verify each expected result
   - Test edge cases

---

**Ready to Begin Testing!**

The frontend should already be open at http://localhost:3000. Follow the steps above to complete the manual integration testing.
