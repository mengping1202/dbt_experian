{% macro flatten_json_response(

    source_table,
    response_field,
    top_level_fields=[], 
    nested_path=None,
    additional_columns=[], 
    recursive=false, 
    experian_model=None
    
) %}

    select 
        -- Unique identifier (pending)
        
        -- Additional columns
        {% for col in additional_columns %}
        {{ col }},
        {% endfor %}
        
        -- Dynamic top-level fields
        {% for field in top_level_fields %}
        try_parse_json({{ response_field }}):{{ field }}::string as {{ field }},
        {% endfor %}
        
        -- Flattened fields
        f.value::string as field_value,
        f.path as full_path,
        
        {% if experian_model %}
            '{{ experian_model }}'
        {% else %}
            split(f.path, '.')[0]
        {% endif %} as experian_model,

        
    from {{ source_table }},
    lateral flatten(
        input => try_parse_json({{ response_field }}){% if nested_path %}:{{ nested_path }}{% endif %}
        
        {% if recursive %} 
            , recursive => true 
        {% endif %}
    ) f
    where typeof(f.value) != 'OBJECT'
    and f.path not ilike '%[%'

{% endmacro %}