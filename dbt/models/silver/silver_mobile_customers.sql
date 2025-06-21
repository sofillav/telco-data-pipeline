with source as (
    select 
        data::jsonb as json_data
    from {{ source('bronze', 'bronze_mobile_customers') }}
),

extracted as (
    select
        -- Generate surrogate key by hashing customer_id, operator, first_name, last_name
        {{ generate_customer_sk('json_data') }} as customer_sk,


        -- Normalize first name (trim, lowercase, remove digits, capitalize)
        {{ normalize_name("json_data ->> 'first_name'") }} as first_name,

        -- Normalize last name (same as first name)
        {{ normalize_name("json_data ->> 'last_name'") }} as last_name,

        -- Clean email by trimming, lowercasing; convert empty strings to NULL
        nullif(lower(trim(json_data ->> 'email')), '') as email,

        -- Extract phone number as-is from JSON
        json_data ->> 'phone_number' as phone_number,
        
        -- Convert age to integer if valid (0-110), else NULL
        case
            when floor((json_data ->> 'age')::numeric) between 0 and 110
                then floor((json_data ->> 'age')::numeric)::int
            else null 
        end as age,


        -- Normalize country name to ISO code
        {{ normalize_country("json_data ->> 'country'") }} as country_raw,

        -- Normalize city name with mapping and cleanup
        {{ normalize_city("json_data ->> 'city'") }} as city,


        -- Normalize operator names to canonical form (e.g., Claro, Movistar, Tigo, WOM)
        {{ normalize_operator("json_data ->> 'operator'") }} as operator,

        -- Normalize plan type to known categories (e.g., control, pospago, prepago)
        {{ normalize_plan_type("json_data ->> 'plan_type'") }} as plan_type,

        -- Convert monthly data allowance to numeric
        (json_data ->> 'monthly_data_gb')::numeric as monthly_data_gb,

        -- Convert current month data usage to numeric
        (json_data ->> 'data_usage_current_month')::numeric as data_gb_usage_current_month,

        -- Convert monthly bill amount to numeric USD value
        (json_data ->> 'monthly_bill_usd')::numeric as monthly_bill_usd,

        
        -- Normalize registration date to proper date format
        {{ normalize_hour("json_data ->> 'registration_date'") }} as registration_date,

        -- Convert last payment date to SQL date type
        (json_data ->> 'last_payment_date')::date as last_payment_date,


        -- Normalize customer status (e.g., active, inactive, suspended, etc.)
        {{ normalize_status("json_data ->> 'status'") }} as status,


        -- Normalize device brand names (e.g., Apple, Samsung)
        {{ normalize_device_brand("json_data ->> 'device_brand'") }} as device_brand,

        -- Clean device model string (trim, lowercase, null if empty)
        nullif(lower(trim(json_data ->> 'device_model')), '') as device_model,


        -- Convert credit limit to numeric
        (json_data ->> 'credit_limit')::numeric as credit_limit,

        -- Convert credit score to integer
        (json_data ->> 'credit_score')::int as credit_score
    from source
)

select
    e.customer_sk,

    e.first_name,
    e.last_name,
    e.email,
    e.phone_number,
    e.age,

    c.city_sk,
    e.country_raw,

    e.operator,
    e.plan_type,
    e.monthly_data_gb,
    e.data_gb_usage_current_month,
    e.monthly_bill_usd,

    e.registration_date,
    e.last_payment_date,

    e.status,

    e.device_brand,
    e.device_model,

    e.credit_limit,
    e.credit_score
from extracted e
left join {{ ref('silver_cities') }} c
  on e.city = c.name