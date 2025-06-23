
-- What percentage of customers have payment issues?

-- Which customers have pending payments?

-- How does credit score correlate with payment behavior?

select
    ph.customer_sk,
    ph.status,
    ph.payment_date,
    mc.credit_score,
    case
        when mc.credit_score is null then 'Unknown'
        when mc.credit_score < 580 then 'Poor'
        when mc.credit_score < 670 then 'Fair'
        when mc.credit_score < 740 then 'Good'
        when mc.credit_score < 800 then 'Very Good'
        when mc.credit_score <= 850 then 'Excellent'
    end as credit_score_group
from {{ ref('silver_payment_history') }} ph
join {{ ref('silver_mobile_customers') }} mc 
    on ph.customer_sk = mc.customer_sk
