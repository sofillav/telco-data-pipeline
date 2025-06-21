
-- Test: Validate that all monthly_bill_usd values are nonnegative
-- Returns any rows where monthly_bill_usd is outside the expected range, indicating data quality issues

SELECT *
FROM {{ ref('silver_mobile_customers') }}
WHERE monthly_bill_usd IS NOT NULL AND monthly_bill_usd < 0