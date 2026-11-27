select
    ifnull(promo_name, 'ALL PROMOTIONS')                            as promotion,
    if(promo_name is null, null, any_value(discount_pct))           as discount_pct,
    count(*)                                                        as months_compared,
    round(avg(qty_lift_pct), 1)                                     as avg_qty_lift_pct,
    round(avg(gp_lift_pct), 1)                                      as avg_gp_lift_pct,
    round(safe_divide(countif(gp_lift_pct > 0), count(*)) * 100, 0) as pct_months_gp_up
from {{ ref('h2_promo_did') }}
group by grouping sets ((promo_name), ())