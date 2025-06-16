with source as (
    select 
        data::jsonb as json_data
    from {{ source('bronze', 'mobile_customers') }}
),

extracted as (
    select
        (json_data ->> 'customer_id')::int as customer_id,
        json_data ->> 'first_name' as first_name,
        json_data ->> 'last_name' as last_name,
        json_data ->> 'email' as email,
        json_data ->> 'phone_number' as phone_number,
        
        -- Convert age with decimals to integer
        floor((json_data ->> 'age')::numeric)::int as age,

        json_data ->> 'country' as country,
        json_data ->> 'city' as city,
        json_data ->> 'operator' as operator,
        json_data ->> 'plan_type' as plan_type,
        (json_data ->> 'monthly_data_gb')::numeric as monthly_data_gb,
        (json_data ->> 'monthly_bill_usd')::numeric as monthly_bill_usd,

        json_data ->> 'registration_date' as raw_registration_date,
        -- Parsed version:
        case
        when json_data ->> 'registration_date' ~ '^\d{4}-\d{2}-\d{2}$' then to_date(json_data ->> 'registration_date', 'YYYY-MM-DD')
        when json_data ->> 'registration_date' ~ '^\d{2}-\d{2}-\d{4}$' then to_date(json_data ->> 'registration_date', 'MM-DD-YYYY')
        when json_data ->> 'registration_date' ~ '^\d{2}-\d{2}-\d{2}$' then to_date(json_data ->> 'registration_date', 'DD-MM-YY')
        when json_data ->> 'registration_date' ~ '^\d{2}/\d{2}/\d{4}$' then to_date(json_data ->> 'registration_date', 'DD/MM/YYYY')
        else null
        end as registration_date,

        json_data ->> 'status' as status,
        json_data ->> 'device_brand' as device_brand,
        json_data ->> 'device_model' as device_model,
        json_data ->> 'record_uuid' as record_uuid,
        (json_data ->> 'last_payment_date')::date as last_payment_date,
        (json_data ->> 'credit_limit')::numeric as credit_limit,
        (json_data ->> 'data_usage_current_month')::numeric as data_usage_current_month,
        (json_data ->> 'latitude')::float as latitude,
        (json_data ->> 'longitude')::float as longitude,
        (json_data ->> 'credit_score')::int as credit_score,
        current_timestamp as transformed_at
    from source
)

select * from extracted