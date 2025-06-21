
-- Test: Validate that all credit_score values fall within the valid range (300–850)
-- Returns any rows where credit_score is outside the expected range, indicating data quality issues

select *
from {{ ref('silver_mobile_customers') }}
where credit_score is not null
  and (credit_score < 300 or credit_score > 850)
