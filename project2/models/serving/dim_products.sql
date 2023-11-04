with stg_products as (
    select
        product_id,
        product_name,
        supplier_id,
        category_id,
        quantity_per_unit,
        unit_price,
        units_in_stock,
        units_on_order,
        reorder_level,
        discontinued
    from
        {{ ref('stg_products') }}
),

stg_categories as (
    select
        category_id,
        category_name,
        description,
        picture,
        modifieddate
    from
        {{ ref('stg_categories') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key,
    {{ dbt_utils.generate_surrogate_key(['supplier_id']) }} as supplier_key,
    product_id,
    product_name,
    stg_categories.category_name,
    stg_categories.description as category_description,
    quantity_per_unit,
    unit_price as product_unit_price,
    units_in_stock,
    units_on_order,
    reorder_level,
    discontinued
from stg_products
left join stg_categories on stg_categories.category_id = stg_products.category_id
    