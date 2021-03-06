{% macro test_accepted_values(model,column_name,values,sql,dq_dimension = 'Validity',rule_description = 'To check if there data has any garbage values or unacceptable values',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

{% set quote_values = kwargs.get('quote', True) %}

with validation_errors as (
    select
        *
    from {{ model }}
    where {{ column_name }} not in (
    {% if values is not mapping %}
        {% for value in values -%}
            {% if quote_values -%}
                '{{ value }}'
            {%- else -%}
                {{ value }}
            {%- endif -%}
            {%- if not loop.last -%},{%- endif %}
        {%- endfor %} 
    {% elif values is mapping %}
        select {{ values.from_column }} from {{ values.table }}
    {% endif %}
    )
)

select
    count(*) as validation_errors
from validation_errors

{% endmacro %}