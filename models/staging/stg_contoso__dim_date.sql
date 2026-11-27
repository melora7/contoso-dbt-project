select
    Datekey                     as date_key,
    CalendarYear                as calendar_year,
    CalendarQuarter             as calendar_quarter,
    CalendarMonth               as calendar_month,
    extract(month from Datekey) as month_no
from {{ source('contoso', 'DimDate') }}