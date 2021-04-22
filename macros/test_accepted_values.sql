{% macro test_accepted_values(model,column_name,values,sql,dq_dimension = 'Validity',rule_description = 'To check if there data has any garbage values or unacceptable values',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

{% set quote_values = kwargs.get('quote', True) %}

{% if values %}
    set txt = {% for value in values -%}
                    {% if quote_values -%}
                    '{{ value }}'
                    {%- else -%}
                    {{ value }}
                    {%- endif -%}
                    {%- if not loop.last -%},{%- endif %}
              {%- endfor %}
{% elif sql %}
    set txt = sql
{% endif %}

with validation_errors as (
    select
        {{ column_name }}
    from {{ model }}
    where {{ column_name }} not in (
        {{ txt }}
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