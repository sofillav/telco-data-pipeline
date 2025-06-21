
{# 
    Macro: generate_customer_sk

    Description:
    Generates a surrogate key for a customer by concatenating
    customer_id, operator, first_name, and last_name fields from JSON data,
    then applying an MD5 hash to produce a consistent unique identifier.

    Parameters:
    - json_data: JSON object containing customer attributes.

    Example:
    {{ generate_customer_sk(my_json_column) }}
#}

{% macro generate_customer_sk(json_data) %}
    md5(
        coalesce({{ json_data }} ->> 'customer_id', '') || 
        coalesce({{ json_data }} ->> 'operator', '') || 
        coalesce({{ json_data }} ->> 'first_name', '') || 
        coalesce({{ json_data }} ->> 'last_name', '')
    )
{% endmacro %}