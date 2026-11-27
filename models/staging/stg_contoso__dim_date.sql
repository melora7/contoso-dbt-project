select
    Datekey                         as date_key,
    CalendarYear                    as calendar_year,
    extract(quarter from Datekey)   as calendar_quarter,
    extract(month   from Datekey)   as month_no
from {{ source('contoso', 'DimDate') }}