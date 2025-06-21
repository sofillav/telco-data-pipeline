-- Extract raw JSON data from bronze layer
with source as (
    select 
        data::jsonb as json_data
    from {{ source('bronze', 'bronze_mobile_customers') }}
),

extracted as (

    -- Case 1: Handle contracted_services stored as a JSON array
    select
        -- Generate surrogate key for the customer
        {{ generate_customer_sk('json_data') }} as customer_sk,

        -- Extract each service directly from the JSON array
        contracted_service as service
    from source,
    lateral jsonb_array_elements_text(json_data -> 'contracted_services') as contracted_service
    where jsonb_typeof(json_data -> 'contracted_services') = 'array'

    union all

    -- Case 2: Handle contracted_services stored as a comma-separated string
    select
        -- Generate surrogate key for the customer
        {{ generate_customer_sk('json_data') }} as customer_sk,

        -- Split and trim each service from the string
        trim(service) as service
    from source,
    lateral unnest(string_to_array(json_data ->> 'contracted_services', ',')) as service
    where jsonb_typeof(json_data -> 'contracted_services') = 'string'
)

-- Return distinct customer-service combinations
select distinct
    customer_sk,
    service
from extracted
