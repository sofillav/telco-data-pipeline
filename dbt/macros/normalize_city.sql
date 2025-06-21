{# 
    Macro: normalize_city

    Description:
    Standardizes city names by trimming spaces, lowercasing the input,
    and mapping known variants to a canonical city name.
    Returns NULL for unknown values.

    Example:
    {{ normalize_city(' CDMX ') }} → 'Ciudad de México'
#}

{% macro normalize_city(city_raw) %}
  {% set cleaned_value = "lower(trim(" ~ city_raw ~ "))" %}
  case
    when {{ cleaned_value }} in ('areqipa', 'arequipa') then 'Arequipa'
    when {{ cleaned_value }} in ('barranquilla') then 'Barranquilla'
    when {{ cleaned_value }} in ('bogotá', 'bogota') then 'Bogotá'
    when {{ cleaned_value }} in ('buenos aires') then 'Buenos Aires'
    when {{ cleaned_value }} in ('cal', 'cali') then 'Cali'
    when {{ cleaned_value }} in ('cdmx', 'ciudad de mexico', 'ciudad de méxico') then 'Ciudad de México'
    when {{ cleaned_value }} in ('concepción', 'concepcion') then 'Concepción'
    when {{ cleaned_value }} in ('córdoba', 'cordoba', 'coroba') then 'Córdoba'
    when {{ cleaned_value }} in ('guadaljara', 'guadalajara') then 'Guadalajara'
    when {{ cleaned_value }} in ('lima') then 'Lima'
    when {{ cleaned_value }} in ('medelin', 'medellin') then 'Medellín'
    when {{ cleaned_value }} in ('monterrey') then 'Monterrey'
    when {{ cleaned_value }} in ('rosario') then 'Rosario'
    when {{ cleaned_value }} in ('santigo', 'santiago') then 'Santiago'
    when {{ cleaned_value }} in ('trujillo') then 'Trujillo'
    when {{ cleaned_value }} in ('valparaíso', 'valparaiso') then 'Valparaíso'
    else null
  end
{% endmacro %}
