select
    orders.order_id,
    order_details.product_id,
    customer_id,
    order_date,
    required_date,
    shipped_date,
    ship_via,
    freight,
    ship_name,
    ship_address,
    ship_city,
    ship_region,
    ship_postal_code,
    ship_country,
    unit_price,
    quantity,
    discount
from {{ source('orders', 'orders') }} as orders
inner join {{ source('orders', 'order_details') }} as order_details on orders.order_id = order_details.order_id
