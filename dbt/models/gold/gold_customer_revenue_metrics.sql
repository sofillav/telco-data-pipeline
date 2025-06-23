
-- What is the average revenue per user (ARPU) by plan type?

-- What is the revenue distribution by geographic location?

-- Which customer segments generate the highest revenue?

-- How do the mean and median monthly revenues per user compare across different plan types and operators?

select
    mc.customer_sk,
    mc.plan_type,
    mc.operator,
    ci.country,
    ci.name as city,
    mc.age,
    case
        when mc.age is null then 'Unknown'
        when mc.age < 30 then 'Young'
        when mc.age between 30 and 59 then 'Adult'
        when mc.age >= 60 then 'Senior'
    end as age_group,
    mc.credit_score,
    mc.monthly_bill_usd
from {{ ref('silver_mobile_customers') }} mc
left join {{ ref('silver_cities') }} ci
    on mc.city_sk = ci.city_sk
where mc.monthly_bill_usd is not null

