with stg_customers as (
    select
        customer_id,
        company_name,
        contact_name,
        contact_title,
        address,
        city,
        region,
        postal_code,
        country,
        phone,
        fax
    from
        {{ ref('stg_customers') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['address',
        'city',
        'region',
        'postal_code',
        'country']) }} as customer_address_key,
    customer_id,
    company_name,
    contact_name,
    contact_title,
    phone,
    fax
from
    stg_customers