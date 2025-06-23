
-- How does the distribution of new customers change over time?

-- What are customer acquisition trends by operator?

select
    customer_sk,
    operator,
    date_part('year', registration_date) as registration_year,
    date_part('month', registration_date) as registration_month
from {{ ref('silver_mobile_customers') }}
where registration_date is not null

