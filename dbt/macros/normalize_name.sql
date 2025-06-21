{# 
    Macro: normalize_name

    Description:
    Cleans and standardizes a name by removing digits, trimming spaces,
    lowercasing all letters, and capitalizing the first letter of each word.
    Returns NULL if the result is empty.

    Example:
    {{ normalize_name('  ANA sofía1 ') }} → 'Ana Sofía'
#}


{% macro normalize_name(name_raw) %}
    nullif(
        initcap(
            trim(
                regexp_replace(
                    lower({{ name_raw }}),
                    '[0-9]',
                    '',
                    'g'
                )
            )
        ),
        ''
    )
{% endmacro %}

