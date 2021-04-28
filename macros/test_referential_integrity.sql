{% macro test_referential_integrity(model,to,field,dq_dimension = 'Consistency',rule_description = 'To check if PK-FK relationship is correct',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

{% set column_name = kwargs.get('column_name', kwargs.get('from')) %}

select 
    count(*) as validation_errors
from (
    select *,{{ column_name }} as col_id from {{ model }}
) as child
left join (
    select *,{{ field }} as col_id from {{ to }}
) as parent on parent.col_id = child.col_id
where child.col_id is not null
  and parent.col_id is null

{% endmacro %}



{% test relationships(model, to, field) %}
    {% set macro = adapter.dispatch('test_referential_integrity') %}
    {{ macro(model, to, field, **kwargs) }}
{% endtest %}