{% macro pivot_with_snake_case(

    source_table,
    value_column,
    pivot_column,
    group_by_columns=[],
    agg_function='max', 
    filter_expression='1=1'
    
) %}

    -- Get distinct pivot values from source
    {% set results = run_query(
        "select " ~ pivot_column ~ 
        " from " ~ source_table ~ 
        " where " ~ filter_expression ~ 
        " group by 1 order by 1"
    ) %}

    {% if execute %}
      {% set pivot_values = results.columns[0].values() %}
    {% else %}
      {% set pivot_values = [] %}
    {% endif %}

    with base as (
        select
            {% for col in group_by_columns %}
                {{ col }}{% if not loop.last %},{% endif %}
            {% endfor %},
            {{ value_column }},
            {{ pivot_column }}
        from {{ source_table }}
        where {{ filter_expression }}
        
    )

    , pivoted as (
        select
            {% for col in group_by_columns %}
                {{ col }}{% if not loop.last %},{% endif %}
            {% endfor %}
            {% for val in pivot_values %}
                ,"'{{ val }}'" as {{ val | lower | replace(".", "_") | replace(" ", "_") }}
            {% endfor %}
        from base
        pivot (
            {{ agg_function }}({{ value_column }}) for {{ pivot_column }} in (
                {% for val in pivot_values %}
                    '{{ val }}'{% if not loop.last %},{% endif %}
                {% endfor %}
            )
        )
    )

    select * from pivoted

{% endmacro %}
