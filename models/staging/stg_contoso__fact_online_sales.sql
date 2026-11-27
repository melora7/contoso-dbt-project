select
    OnlineSalesKey              as online_sales_key,
    DateKey                     as date_key,
    StoreKey                    as store_key,
    ProductKey                  as product_key,
    PromotionKey                as promotion_key,
    CustomerKey                 as customer_key,
    SalesOrderNumber            as sales_order_number,
    SalesQuantity               as sales_quantity,
    ReturnQuantity              as return_quantity,
    ReturnAmount                as return_amount,
    DiscountAmount              as discount_amount,
    TotalCost                   as total_cost,
    SalesAmount                 as sales_amount,
    SalesAmount - TotalCost     as gross_profit
from {{ source('contoso', 'FactOnlineSales') }}