

{% macro nonnegative_numeric(number_raw) %}
    CASE 
        WHEN ({{ number_raw }})::numeric < 0 THEN NULL
        ELSE ({{ number_raw }})::numeric
    END
{% endmacro %}