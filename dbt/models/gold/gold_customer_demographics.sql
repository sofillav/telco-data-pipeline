
-- What is the distribution of customers by location?

-- What is the age distribution of customers by plan type?

-- What is the age distribution by country and operator?

-- How are customers distributed across different operators?

-- What percentage of customers are active/suspended/inactive?

select
    mc.customer_sk,
    mc.age,
    case
        when mc.age is null then 'Unknown'
        when mc.age < 30 then 'Young'
        when mc.age between 30 and 59 then 'Adult'
        when mc.age >= 60 then 'Senior'
    end as age_group,
    mc.plan_type,
    mc.operator,
    mc.status,
    ci.name as city,
    ci.country
from {{ ref('silver_mobile_customers') }} mc
left join {{ ref('silver_cities') }} ci
    on mc.city_sk = ci.city_sk

