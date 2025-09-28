{% set fields = [
    "DateOfAccounts", "Currency", "CompanyClass", "ConsAccounts", "CurrentRatio",
    "AcidTest", "CreditPeriod", "WorkingCapSales", "TradeCredrsDebtrs", "ReturnOnCapital",
    "ReturnOnAssets", "PreTaxProfitMargin", "ReturnOnShareholdersFunds", "BorrowingRatio",
    "EquityGearing", "DebtGearing", "InterestCover", "SalesTangAssets", "AvgRemPerEmp",
    "ProfitPerEmp", "TurnoverPerEmp", "CapEmployedPerEmp", "TangAssetsPerEmp",
    "TotAssetsPerEmp", "EmpRemunerationSales", "NumEmployees", "EmpRemuneration", "DirRemuneration"
] %}

select 
    response_id, 
    created_at,
    

    {% for f in fields %}
        f.value:{{ f }} as {{ f }}{% if not loop.last %},{% endif %}
    {% endfor %}

    
from {{ref('int_financials') }},
lateral flatten(input => parse_json(financials_ratios)) f