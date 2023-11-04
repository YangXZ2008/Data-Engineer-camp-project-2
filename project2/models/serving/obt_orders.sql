with dim_address as (
    select
        address_key,
        address,
        city,
        region,
        postal_code,
        country
    from
        {{ ref('dim_address') }}
),

dim_customer as (
    select
        customer_key,
        customer_address_key,
        customer_id,
        company_name,
        contact_name,
        contact_title,
        phone,
        fax
    from
        {{ ref('dim_customer') }}
),

dim_date as (
    select
        date_day_key,
        date_day
    from
        {{ ref('dim_date') }}
),

dim_shippers as (
    select
        shipper_key,
        shipper_id,
        shipper_name,
        shipper_phone
    from
        {{ ref('dim_shippers') }}
),

dim_suppliers as (
    select
        supplier_key,
        supplier_address_key,
        supplier_id,
        supplier_name,
        supplier_contact_title,
        supplier_phone,
        supplier_fax,
        homepage
    from
        {{ ref('dim_suppliers') }}
),

dim_products as (
    select
        product_key,
        supplier_key,
        product_id,
        product_name,
        category_name,
        category_description,
        quantity_per_unit,
        product_unit_price,
        units_in_stock,
        units_on_order,
        reorder_level,
        discontinued
    from
        {{ ref('dim_products') }}
),

fact_orders as (
    select
        order_key,
        customer_key,
        order_date_key,
        required_date_key,
        shipped_date_key,
        shipper_key,
        ship_address_key,
        product_key,
        order_id,
        ship_via,
        freight,
        unit_price,
        quantity,
        discount
    from
        {{ ref('fact_orders') }}
)

select
    {{ dbt_utils.star(from=ref('fact_orders'), relation_alias='fact_orders', except=['order_key', 'customer_key', 'order_date_key', 'required_date_key',
    'shipped_date_key', 'shipper_key', 'ship_address_key', 'product_key']) }},
    {{ dbt_utils.star(from=ref('dim_customer'), relation_alias='dim_customer', except=['customer_key', 'customer_address_key']) }},
    {{ dbt_utils.star(from=ref('dim_products'), relation_alias='dim_products', except=['product_key', 'supplier_key']) }},
    {{ dbt_utils.star(from=ref('dim_suppliers'), relation_alias='dim_suppliers', except=['supplier_key', 'supplier_address_key']) }},
    order_date.date_day as order_date,
    required_date.date_day as required_date,
    shipped_date.date_day as shipped_date,
    ship_address.address as ship_address,
    ship_address.city as ship_city,
    ship_address.region as ship_region,
    ship_address.postal_code as ship_postal_code,
    ship_address.country as ship_country,
    customer_address.address as customer_address,
    customer_address.city as customer_city,
    customer_address.region as customer_region,
    customer_address.postal_code as customer_postal_code,
    customer_address.country as customer_country,
    supplier_address.address as supplier_address,
    supplier_address.city as supplier_city,
    supplier_address.region as supplier_region,
    supplier_address.postal_code as supplier_postal_code,
    supplier_address.country as supplier_country
from fact_orders
left join dim_customer on fact_orders.customer_key = dim_customer.customer_key
left join dim_products on fact_orders.product_key = dim_products.product_key
left join dim_suppliers on dim_products.supplier_key = dim_suppliers.supplier_key
left join dim_address as ship_address on fact_orders.ship_address_key = ship_address.address_key
left join dim_address as customer_address on dim_customer.customer_address_key = customer_address.address_key
left join dim_address as supplier_address on dim_suppliers.supplier_address_key = supplier_address.address_key
left join dim_date as order_date on order_date.date_day_key = fact_orders.order_date_key
left join dim_date as required_date on required_date.date_day_key = fact_orders.required_date_key
left join dim_date as shipped_date on shipped_date.date_day_key = fact_orders.shipped_date_key