with dim_products as (
    select
        product_key,
        product_id,
        product_name,
        category_name,
        category_description
    from
        {{ ref('dim_products') }}
),

dim_date as (
    select
        date_day_key,
        date_day,
        month_end_date
    from
        {{ ref('dim_date') }} 
),

stg_orders as (
    select
        order_id,
        product_id,
        order_date,
        quantity
    from {{ ref('stg_orders') }}
),

transform as (
    select
        sum(quantity) as quantity,
        stg_orders.product_id,
        month_end_date
    from stg_orders
    left join dim_products on dim_products.product_id = stg_orders.product_id
    left join dim_date ON  stg_orders.order_date = dim_date.date_day
    group by stg_orders.product_id, month_end_date
    order by month_end_date
)

select
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key,
    {{ dbt_utils.generate_surrogate_key(['month_end_date']) }} as month_end_date_key,
    quantity
from transform