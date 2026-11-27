select
    PromotionKey                as promotion_key,
    PromotionName               as promotion_name,
    PromotionType               as promotion_type,
    PromotionCategory           as promotion_category,
    DiscountPercent             as discount_percent,
    PromotionType != 'No Discount' as is_promo,
    case
        when PromotionType = 'No Discount'      then 'No promo'
        when PromotionName like '%Holiday%'      then 'Holiday'
        when PromotionName like '%Back-to-Sch%'  then 'Back-to-School'
        when PromotionName like '%Spring%'       then 'Spring'
        when PromotionName like '%Summer%'       then 'Summer'
        else 'Other'
    end                         as promo_season,
    case
        when PromotionName like 'North America%' then 'North America'
        when PromotionName like 'Asian%'         then 'Asia'
        when PromotionName like 'European%'      then 'Europe'
        else null
    end                         as promo_region
from {{ source('contoso', 'DimPromotion') }}