select 

    response_id, 
    created_at, 

    f.value:DateOfAccounts as date_of_accounts,
    f.value:AccountingPeriod as accounting_period,
    f.value:Currency as currency,
    f.value:CurrencyMultiplier as currency_multiplier,
    f.value:CompanyClass as company_class,
    f.value:ConsolidatedAccounts as consolidated_acocounts,

    f.value:DormancyFlag as dormancy_flag,
    f.value:LatestAccountsType as lates_account_type,
    f.value:RestatedAccounts as restated_accounts,
    f.value:ContingentLiability as contingent_liability,
    f.value:PostBalanceSheetEvents as post_balance_sheet_events,
    f.value:CharitableGivingIndicator as charitable_giving_indicator,

    -- need further parsing
    f.value:BalanceSheet as balance_sheet,
    f.value:ProfitLoss as profit_loss,
    f.value:DiscontinuedOperations as discontinued_operations,
    f.value:DisclosureItems as disclosure_items,

from {{ ref('int_financials') }},
lateral flatten(input => parse_json(financials_accounts)) f
