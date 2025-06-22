
-- What are the most popular device brands?

-- What is device brand preference by country/operator?

-- What is device brand preference by plan type?

select
    mc.customer_sk,
    mc.device_brand,
    mc.plan_type,
    mc.operator,
    ci.country
from {{ ref('silver_mobile_customers') }} mc
left join {{ ref('silver_cities') }} ci
on mc.city_sk = ci.city_sk
where mc.device_brand is not null
