select
    shipper_id,
    company_name,
    phone
from
    {{ source('orders', 'shippers') }}