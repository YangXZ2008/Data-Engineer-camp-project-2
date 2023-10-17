select
    shipper_id,
    company_name,
    phone
from
    {{ sources('orders', 'shippers') }}