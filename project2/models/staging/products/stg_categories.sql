select
    category_id,
    category_name,
    description,
    picture
from
    {{ source('products', 'categories') }}