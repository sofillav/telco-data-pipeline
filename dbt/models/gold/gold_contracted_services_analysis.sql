
-- Which services are most commonly contracted?

-- What service combinations are most popular?

-- Which service combinations drive highest revenue?

select
    cs.customer_sk,
    mc.plan_type,
    mc.operator,
    mc.monthly_bill_usd,
    cs.service
from {{ ref('silver_contracted_services') }} cs
join {{ ref('silver_mobile_customers') }} mc
on cs.customer_sk = mc.customer_sk
