with stg_shippers as (
    select
        shipper_id,
        company_name,
        phone
    from {{ ref('stg_shippers') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['shipper_id']) }} as shipper_key,
    shipper_id,
    company_name as shipper_name,
    phone as shipper_phone
from stg_shippers