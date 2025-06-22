
-- What percentage of customers have payment issues?

-- Which customers have pending payments?

-- How does credit score correlate with payment behavior?

select
    ph.customer_sk,
    ph.status,
    ph.payment_date,
    mc.credit_score
from {{ ref('silver_payment_history') }} ph
join {{ ref('silver_mobile_customers') }} mc 
on ph.customer_sk = mc.customer_sk
