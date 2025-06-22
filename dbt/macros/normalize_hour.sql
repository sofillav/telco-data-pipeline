
{# 
    Macro: normalize_hour

    Description:
    Parses a date string in various common formats and converts it to a standardized DATE.
    Supports formats like YYYY-MM-DD, MM-DD-YYYY, DD-MM-YY, and DD/MM/YYYY.
    Returns NULL if the format is unrecognized or if the resulting date is after '2025-06-12'.

    Example:
    {{ normalize_hour('12/06/2025') }} → date '2025-06-12'
    {{ normalize_hour('13/06/2025') }} → null
#}

{% macro normalize_hour(hour_raw) %}
  case
    when {{ hour_raw }} ~ '^\d{4}-\d{2}-\d{2}$' and to_date({{ hour_raw }}, 'YYYY-MM-DD') <= date '2025-06-12'
      then to_date({{ hour_raw }}, 'YYYY-MM-DD')
    when {{ hour_raw }} ~ '^\d{2}-\d{2}-\d{4}$' and to_date({{ hour_raw }}, 'MM-DD-YYYY') <= date '2025-06-12'
      then to_date({{ hour_raw }}, 'MM-DD-YYYY')
    when {{ hour_raw }} ~ '^\d{2}-\d{2}-\d{2}$' and to_date({{ hour_raw }}, 'DD-MM-YY') <= date '2025-06-12'
      then to_date({{ hour_raw }}, 'DD-MM-YY')
    when {{ hour_raw }} ~ '^\d{2}/\d{2}/\d{4}$' and to_date({{ hour_raw }}, 'DD/MM/YYYY') <= date '2025-06-12'
      then to_date({{ hour_raw }}, 'DD/MM/YYYY')
    else null
  end
{% endmacro %}

