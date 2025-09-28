select 
    response_id, 
    created_at, 

    f.value:DateOfAccounts as date_of_accounts,
    f.value:AccountingPeriod as accounting_period,
    f.value:Currency as currency,
    f.value:CurrencyMultiplier as currency_multiplier,
    f.value:CompanyClass as company_class,

    f.value:ConsAccounts as cons_accounts,

    f.value:DormancyIndicator as dormancy_indicator,
    f.value:LatestAccountsType as lates_account_type,
    f.value:RestatedAccounts as restated_accounts,
    
from {{ ref('int_financials') }},
lateral flatten(input => parse_json(financials_cashflow)) f