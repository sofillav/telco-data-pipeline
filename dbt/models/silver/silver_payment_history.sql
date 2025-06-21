-- Extract raw JSON data from bronze layer
with source as (
    select 
        data::jsonb as json_data
    from {{ source('bronze', 'bronze_mobile_customers') }}
)

-- Case 1: Handle payment_history stored as a JSON array
, from_array as (
    select
        -- Generate surrogate key for the customer
        {{ generate_customer_sk('json_data') }} as customer_sk,

        -- Extract payment date and cast to SQL date
        (payment ->> 'date')::date as payment_date,

        -- Extract payment status as-is
        payment ->> 'status' as status,

        -- Convert amount to numeric; treat 'unknown' as NULL
        nullif(payment ->> 'amount', 'unknown')::numeric as amount
    from source,
    lateral jsonb_array_elements(json_data -> 'payment_history') as payment
    where jsonb_typeof(json_data -> 'payment_history') = 'array'
)

-- Case 2: Handle payment_history stored as a comma-separated string
, from_string as (
    select
        -- Generate surrogate key for the customer
        {{ generate_customer_sk('json_data') }} as customer_sk,

        -- No date available in this format
        null::date as payment_date,

        -- Extract and clean individual status values
        trim(value) as status,
        
        -- No amount available in this format
        null::numeric as amount
    from source,
    lateral unnest(string_to_array(json_data ->> 'payment_history', ',')) as value
    where jsonb_typeof(json_data -> 'payment_history') = 'string'
)

-- Combine both formats into a unified result
select distinct *
from from_array

union all

select distinct *
from from_string
