
{# 
    Macro: normalize_country

    Description:
    Standardizes country inputs by trimming, lowercasing, and mapping
    common variations to ISO 3-letter country codes.
    Returns NULL for unrecognized values.

    Example:
    {{ normalize_country(' Mejico ') }} → 'MEX'
#}

{% macro normalize_country(country_raw) %}
  {% set cleaned_value = "lower(trim(" ~ country_raw ~ "))" %}
  case
    when {{ cleaned_value }} in ('ar', 'arg', 'argentin', 'argentina', 'argenta', 'argentna') then 'ARG'
    when {{ cleaned_value }} in ('chi', 'chile', 'chl', 'chle', 'cl') then 'CHL'
    when {{ cleaned_value }} in ('co', 'col', 'colombi', 'colombia', 'colomia') then 'COL'
    when {{ cleaned_value }} in ('mejico', 'mex', 'mexco', 'mexico', 'mx') then 'MEX'
    when {{ cleaned_value }} in ('pe', 'per', 'peru', 'pru', 'mx') then 'PER'
    else null
  end
{% endmacro %}
