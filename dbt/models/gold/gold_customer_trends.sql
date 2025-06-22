
-- How does the distribution of new customers change over time?

-- What are customer acquisition trends by operator?

select
    customer_sk,
    operator,
    registration_date
from {{ ref('silver_mobile_customers') }}
where registration_date is not null
