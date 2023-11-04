with stg_date as (
    select
        date_day,
        month_end_date
    from
        {{ ref('stg_date') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['date_day']) }} as date_day_key,
    date_day,
    month_end_date
from stg_date