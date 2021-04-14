{% macro test_custom_br(model,column_name,dq_dimension = 'Validity',rule_description = 'To check validity of data against business rules',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40,br_sql) %}

select 
    count(*) as validation_errors,
    '{{ dq_dimension }}' as dq_dimension,
    '{{ rule_description }}' as rule_description,
    '{{ quality_threshold_lowerbound }}' as quality_threshold_lowerbound,
    '{{ quality_threshold_upperbound }}' as quality_threshold_upperbound

from (
    {{ br_sql }}
    )

{% endmacro %}