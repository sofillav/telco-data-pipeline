
{# 
    Macro: normalize_operator

    Description:
    Standardizes mobile operator names by trimming, lowercasing, and mapping
    common typos or short forms to a canonical brand name.
    Returns NULL if no match is found.

    Example:
    {{ normalize_operator(' Movistr ') }} → 'Movistar'
#}

{% macro normalize_operator(operator_raw) %}
  {% set cleaned_value = "lower(trim(" ~ operator_raw ~ "))" %}
  case
    when {{ cleaned_value }} in ('cla', 'clar', 'claro') then 'Claro'
    when {{ cleaned_value }} in ('mov', 'movi', 'movistar', 'movistr') then 'Movistar'
    when {{ cleaned_value }} in ('tgo', 'tig', 'tigo') then 'Tigo'
    when {{ cleaned_value }} in ('w0m', 'wom', 'won') then 'WOM'
    else null
  end
{% endmacro %}