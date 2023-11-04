select
    category_id,
    category_name,
    description,
    picture,
    modifieddate
from
    {{ source('products', 'categories') }}