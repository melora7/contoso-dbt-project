select
    StoreKey                    as store_key,
    GeographyKey                as geography_key,
    StoreName                   as store_name,
    StoreType                   as store_type,
    SellingAreaSize             as selling_area_size,
    EmployeeCount               as employee_count
from {{ source('contoso', 'DimStore') }}