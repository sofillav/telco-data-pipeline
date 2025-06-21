
-- Test: Validate that all amount values are nonnegative
-- Returns any rows where amount is outside the expected range, indicating data quality issues

SELECT *
FROM {{ ref('silver_payment_history') }}
WHERE amount IS NOT NULL AND amount < 0