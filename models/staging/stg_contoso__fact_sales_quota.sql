select
    SalesQuotaKey               as sales_quota_key,
    DateKey                     as date_key,
    StoreKey                    as store_key,
    ProductKey                  as product_key,
    ScenarioKey                 as scenario_key,
    case ScenarioKey
        when 1 then 'Actual'
        when 2 then 'Budget'
        when 3 then 'Forecast'
    end                         as scenario_name,
    SalesAmountQuota            as sales_amount_quota
from {{ source('contoso', 'FactSalesQuota') }}