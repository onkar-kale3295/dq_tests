{% macro test_accepted_values(model,column_name,values,dq_dimension = 'Validity',rule_description = 'To check if there data has any garbage values or unacceptable values',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

with all_values as (
    select distinct
        {{ column_name }} as value_field

    from {{ model }}
),

validation_errors as (
    select
        value_field
    from all_values
    where value_field not in (
        {% for value in values -%}
            {% if quote_values -%}
            '{{ value }}'
            {%- else -%}
            {{ value }}
            {%- endif -%}
            {%- if not loop.last -%},{%- endif %}
        {%- endfor %}
    )
)

select
    count(*) as validation_errors,
    '{{ dq_dimension }}' as dq_dimension,
    '{{ rule_description }}' as rule_description,
    '{{ quality_threshold_lowerbound }}' as quality_threshold_lowerbound,
    '{{ quality_threshold_upperbound }}' as quality_threshold_upperbound
from validation_errors

{% endmacro %}