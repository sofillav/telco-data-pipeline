
{# 
    Macro: normalize_device_brand

    Description:
    Standardizes device brand names by trimming, lowercasing, and mapping
    common misspellings or variants to a clean brand label.
    Returns NULL if no match is found.

    Example:
    {{ normalize_device_brand(' Xiami ') }} → 'Xiaomi'
#}

{% macro normalize_device_brand(device_brand_raw) %}
  {% set cleaned_value = "lower(trim(" ~ device_brand_raw ~ "))" %}
  case
    when {{ cleaned_value }} in ('aple', 'appl', 'apple') then 'Apple'
    when {{ cleaned_value }} in ('hauwei', 'huawei', 'huwai') then 'HUAWEI'
    when {{ cleaned_value }} in ('samsg', 'samsun', 'samsung') then 'Samsung'
    when {{ cleaned_value }} in ('xaomi', 'xiami', 'xiaomi') then 'Xiaomi'
    else null
  end
{% endmacro %}
