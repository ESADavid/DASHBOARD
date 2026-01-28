#!/usr/bin/env python
"""Test script to verify Plaid SDK imports are working correctly."""

import sys

def test_imports():
    """Test critical Plaid SDK imports."""
    print("Testing Plaid SDK imports...")
    print("-" * 50)
    
    try:
        import plaid
        print(f"✓ plaid module imported successfully")
        print(f"  Version: {plaid.__version__}")
    except ImportError as e:
        print(f"✗ Failed to import plaid: {e}")
        return False
    
    try:
        from plaid.model.payment_amount import PaymentAmount
        print(f"✓ PaymentAmount imported successfully")
    except ImportError as e:
        print(f"✗ Failed to import PaymentAmount: {e}")
        return False
    
    try:
        from plaid.model.products import Products
        print(f"✓ Products imported successfully")
    except ImportError as e:
        print(f"✗ Failed to import Products: {e}")
        return False
    
    try:
        from plaid.model.country_code import CountryCode
        print(f"✓ CountryCode imported successfully")
    except ImportError as e:
        print(f"✗ Failed to import CountryCode: {e}")
        return False
    
    try:
        from plaid.api import plaid_api
        print(f"✓ plaid_api imported successfully")
    except ImportError as e:
        print(f"✗ Failed to import plaid_api: {e}")
        return False
    
    try:
        from plaid.model.link_token_create_request import LinkTokenCreateRequest
        print(f"✓ LinkTokenCreateRequest imported successfully")
    except ImportError as e:
        print(f"✗ Failed to import LinkTokenCreateRequest: {e}")
        return False
    
    print("-" * 50)
    print("✓ ALL IMPORTS SUCCESSFUL!")
    print(f"✓ Plaid SDK v{plaid.__version__} is working correctly")
    return True

if __name__ == "__main__":
    success = test_imports()
    sys.exit(0 if success else 1)
