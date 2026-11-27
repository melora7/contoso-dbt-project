select
    ChannelKey                  as channel_key,
    ChannelName                 as channel_name
from {{ source('contoso', 'DimChannel') }}