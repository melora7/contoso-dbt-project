select
    GeographyKey                          as geography_key,
    any_value(SalesTerritoryGroup)        as territory_group,
    any_value(SalesTerritoryCountry)      as territory_country,
    any_value(SalesTerritoryRegion)       as territory_region
from {{ source('contoso', 'DimSalesTerritory') }}
group by 1