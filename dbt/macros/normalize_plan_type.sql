
{# 
    Macro: normalize_plan_type

    Description:
    Standardizes mobile plan types by trimming, lowercasing, and mapping
    common variations or typos to consistent labels: 'Control', 'Pospago', or 'Prepago'.
    Returns NULL if no match is found.

    Example:
    {{ normalize_plan_type(' post-pago ') }} → 'Pospago'
#}

{% macro normalize_plan_type(plan_type_raw) %}
  {% set cleaned_value = "lower(trim(" ~ plan_type_raw ~ "))" %}
  case
    when {{ cleaned_value }} in ('control', 'contrrol', 'ctrl') then 'Control'
    when {{ cleaned_value }} in ('pos', 'pospago', 'post_pago', 'post-pago') then 'Pospago'
    when {{ cleaned_value }} in ('pre', 'pre_pago', 'prepago', 'pre-pago') then 'Prepago'
    else null
  end
{% endmacro %}