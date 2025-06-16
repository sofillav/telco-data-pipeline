-- Case 1: contracted_services is an array
select
  id as customer_id,
  jsonb_array_elements_text(data -> 'contracted_services') as service
from {{ source('bronze', 'mobile_customers') }}
where jsonb_typeof(data -> 'contracted_services') = 'array'

union all

-- Case 2: contracted_services is a single string
select
  id as customer_id,
  data ->> 'contracted_services' as service
from {{ source('bronze', 'mobile_customers') }}
where jsonb_typeof(data -> 'contracted_services') = 'string'
