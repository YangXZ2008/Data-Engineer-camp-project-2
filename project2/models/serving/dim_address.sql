with stg_customer_address as (
    select
        address,
        city,
        region,
        postal_code,
        country
    from {{ ref('stg_customers') }}
),

stg_shipping_address as (
    select
        ship_address as address,
        ship_city as city,
        ship_region as region,
        ship_postal_code as postal_code,
        ship_country as country
    from
        {{ ref('stg_orders') }}
),

stg_supplier_address as (
    select
        address,
        city,
        region,
        postal_code,
        country
    from
        {{ ref('stg_suppliers') }}
),

stg_all_address as (
    select
        address,
        city,
        region,
        postal_code,
        country
    from
        stg_customer_address
    
    union

    select
        address,
        city,
        region,
        postal_code,
        country
    from
        stg_shipping_address
    
    union

    select
        address,
        city,
        region,
        postal_code,
        country
    from
        stg_supplier_address
)

select
    {{ dbt_utils.generate_surrogate_key(['address',
        'city',
        'region',
        'postal_code',
        'country']) }} as address_key,
    address,
    city,
    region,
    postal_code,
    country
from stg_all_address
