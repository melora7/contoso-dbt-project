select
    SalesKey                    as sales_key,
    DateKey                     as date_key,
    channelKey                  as channel_key,
    StoreKey                    as store_key,
    ProductKey                  as product_key,
    PromotionKey                as promotion_key,
    UnitCost                    as unit_cost,
    UnitPrice                   as unit_price,
    SalesQuantity               as sales_quantity,
    ReturnQuantity              as return_quantity,
    ReturnAmount                as return_amount,
    DiscountQuantity            as discount_quantity,
    DiscountAmount              as discount_amount,
    TotalCost                   as total_cost,
    SalesAmount                 as sales_amount,
    SalesAmount - TotalCost     as gross_profit
from {{ source('contoso', 'FactSales') }}