with stg_suppliers as (
    select
        supplier_id,
        company_name,
        contact_title,
        address,
        city,
        region,
        postal_code,
        country,
        phone,
        fax,
        homepage
    from
        {{ ref('stg_suppliers') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['supplier_id']) }} as supplier_key,
    {{ dbt_utils.generate_surrogate_key(['address', 'city', 'region', 'postal_code', 'country'] )}} as supplier_address_key,
    supplier_id,
    company_name as supplier_name,
    contact_title as supplier_contact_title,
    phone as supplier_phone,
    fax as supplier_fax,
    homepage
from
    stg_suppliers