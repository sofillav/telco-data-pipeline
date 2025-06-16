-- Case 1: payment_history is an array of objects
select
  id as customer_id,
  (payment ->> 'date')::date as payment_date,
  payment ->> 'status' as status,
  nullif(payment ->> 'amount', 'unknown')::numeric as amount
from {{ source('bronze', 'mobile_customers') }},
     jsonb_array_elements(data -> 'payment_history') as payment
where jsonb_typeof(data -> 'payment_history') = 'array'

union all

-- Case 2: payment_history is a comma-separated string
select
  id as customer_id,
  null as payment_date,
  trim(status) as status,
  null as amount
from {{ source('bronze', 'mobile_customers') }},
     unnest(string_to_array(data ->> 'payment_history', ',')) as status
where jsonb_typeof(data -> 'payment_history') = 'string'