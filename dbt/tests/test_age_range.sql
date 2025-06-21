
-- Test: Validate that all age values fall within the valid range (0–110)
-- Returns any rows where age is outside the expected range, indicating data quality issues

SELECT *
FROM {{ ref('silver_mobile_customers') }}
WHERE age IS NOT NULL AND (age < 0 OR age > 110)