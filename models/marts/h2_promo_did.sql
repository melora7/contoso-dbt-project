with cell as (
    select
        t.territory_group                                    as store_region,
        extract(year  from f.date_key)                       as yr,
        extract(month from f.date_key)                       as month_no,
        max(if(p.is_promo, 1, 0))                            as is_promo,
        any_value(if(p.is_promo, p.promotion_name, null))    as promo_name,
        any_value(if(p.is_promo, p.discount_percent, null))  as discount_percent,
        avg(f.sales_quantity)                                as avg_qty,
        avg(f.gross_profit)                                  as avg_gp
    from {{ ref('stg_contoso__fact_sales') }} f
    join {{ ref('stg_contoso__dim_promotion') }} p on f.promotion_key = p.promotion_key
    join {{ ref('stg_contoso__dim_store') }} s     on f.store_key     = s.store_key
    left join {{ ref('stg_contoso__dim_sales_territory') }} t on s.geography_key = t.geography_key
    group by 1, 2, 3
),

indexed as (
    select
        c.*,
        safe_divide(c.avg_qty, avg(c.avg_qty) over (partition by c.store_region, c.yr)) as qty_idx,
        safe_divide(c.avg_gp,  avg(c.avg_gp)  over (partition by c.store_region, c.yr)) as gp_idx
    from cell c
),

month_control as (
    select yr, month_no, avg(qty_idx) as ctrl_qty_idx, avg(gp_idx) as ctrl_gp_idx
    from indexed
    where is_promo = 0
    group by 1, 2
)

select
    i.store_region,
    i.yr,
    i.month_no,
    i.promo_name,
    round(i.discount_percent * 100, 0)                          as discount_pct,
    if(i.discount_percent <= 0.10, 'Low (<=10%)', 'High (20%)') as discount_group,
    (safe_divide(i.qty_idx, mc.ctrl_qty_idx) - 1) * 100         as qty_lift_pct,
    (safe_divide(i.gp_idx,  mc.ctrl_gp_idx)  - 1) * 100         as gp_lift_pct
from indexed i
join month_control mc using (yr, month_no)
where i.is_promo = 1