
{# 
    Macro: normalize_status

    Description:
    Standardizes status values by trimming, lowercasing, and mapping
    common English and Spanish terms to consistent status labels.
    Returns NULL if no match is found.

    Example:
    {{ normalize_status(' Activo ') }} → 'active'
#}

{% macro normalize_status(status_raw) %}
  {% set cleaned_value = "lower(trim(" ~ status_raw ~ "))" %}
  case
    when {{ cleaned_value }} in ('active', 'activo') then 'active'
    when {{ cleaned_value }} in ('inactive', 'inactivo') then 'inactive'
    when {{ cleaned_value }} in ('invalid') then 'invalid'
    when {{ cleaned_value }} in ('suspended', 'suspendido') then 'suspended'
    when {{ cleaned_value }} in ('válido') then 'valid'
    else null
  end
{% endmacro %}