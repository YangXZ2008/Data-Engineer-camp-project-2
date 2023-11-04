{% snapshot snp_categories %}

{{
    config(
        target_schema='serving',
        strategy='timestamp',
        unique_key='category_id',
        updated_at='modifieddate'
    )
}}

select
    category_id,
    category_name,
    description,
    picture,
    modifieddate
from
    {{ source('products', 'categories') }}

{% endsnapshot %}