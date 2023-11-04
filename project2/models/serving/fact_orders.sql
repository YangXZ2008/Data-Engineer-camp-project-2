with stg_orders as (
    select
        order_id,
        product_id,
        customer_id,
        order_date,
        required_date,
        shipped_date,
        ship_via,
        freight,
        ship_name,
        ship_address,
        ship_city,
        ship_postal_code,
        ship_country,
        unit_price,
        quantity,
        discount
    from {{ ref('stg_orders') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['order_id', 'product_id']) }} as order_key,
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['order_date']) }} as order_date_key,
    {{ dbt_utils.generate_surrogate_key(['required_date']) }} as required_date_key,
    {{ dbt_utils.generate_surrogate_key(['shipped_date']) }} as shipped_date_key,
    {{ dbt_utils.generate_surrogate_key(['ship_via']) }} as shipper_key,
    {{ dbt_utils.generate_surrogate_key(['ship_name', 
        'ship_address',
        'ship_city',
        'ship_postal_code',
        'ship_country']) }} as ship_address_key,
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key,
    order_id,
    ship_via,
    freight,
    unit_price,
    quantity,
    discount
from stg_orders
