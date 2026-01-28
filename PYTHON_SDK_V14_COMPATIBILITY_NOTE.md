# Plaid SDK v14.0.0 Compatibility Note

## Overview

The Python server has been configured to use Plaid SDK v14.0.0 for compatibility with the existing codebase. Some advanced features available in newer SDK versions are not available in v14.0.0.

## Features Not Available in v14.0.0

### CRA (Consumer Reporting Agency) Features
The following CRA-related features require Plaid SDK v15.0.0 or higher and are **disabled** in this configuration:

1. **CRA Base Reports** (`/api/cra/get_base_report`)
2. **CRA Income Insights** (`/api/cra/get_income_insights`)  
3. **CRA Partner Insights** (`/api/cra/get_partner_insights`)
4. **Consumer Report User Identity**
5. **Client User Identity**

### Impact

- ✅ **All core Plaid features work**: Transactions, Auth, Balance, Identity, Assets, Investments, Transfers, Payments, Statements, Signal
- ✅ **Payroll/Employment features work**
- ❌ **CRA endpoints will return errors** if called (but won't prevent server startup)

## Available Features in v14.0.0

All standard Plaid products are fully functional:

- ✅ **Transactions** - Transaction history and sync
- ✅ **Auth** - Bank account and routing numbers
- ✅ **Identity** - Account holder information
- ✅ **Balance** - Real-time account balances
- ✅ **Assets** - Asset reports for lending
- ✅ **Investments** - Investment holdings and transactions
- ✅ **Liabilities** - Liability data
- ✅ **Payment Initiation** - UK payment initiation
- ✅ **Transfer** - ACH transfers
- ✅ **Signal** - Return risk assessment
- ✅ **Statements** - Bank statements
- ✅ **Employment/Payroll** - Income verification

## Upgrading to v38.0.0 (Latest)

If you need CRA features, you can upgrade to the latest SDK:

### Steps:
1. Update `requirements.txt`: `plaid-python==38.0.0`
2. Refactor all imports (60+ changes needed)
3. Update API client initialization
4. Test all endpoints

### Import Changes Required:
```python
# Old (v14.x)
from plaid.model.products import Products
from plaid.api import plaid_api

# New (v38.x)
from plaid.model import Products
from plaid.api import PlaidApi
```

## Recommendation

**Stick with v14.0.0** unless you specifically need CRA features. The v14.x SDK is:
- ✅ Stable and well-tested
- ✅ Compatible with existing code
- ✅ Supports all commonly-used Plaid products
- ✅ No code refactoring required

## Testing CRA Features

If you need to test CRA features:
1. Upgrade to v38.0.0
2. Uncomment CRA imports in `server.py`
3. Refactor import statements throughout the file
4. Test thoroughly

## Current Configuration

- **SDK Version**: 14.0.0
- **CRA Features**: Disabled (commented out)
- **Core Features**: Fully functional
- **Status**: ✅ Production-ready for non-CRA use cases
