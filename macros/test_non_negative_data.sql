{% macro test_non_negative(model,column_name,dq_dimension = 'Validity',rule_description = 'To check if the data values has non-negative values. Applicable only for numeric column datatype',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

select 
    count(*) as validation_errors,
    '{{ dq_dimension }}' as dq_dimension,
    '{{ rule_description }}' as rule_description,
    '{{ quality_threshold_lowerbound }}' as quality_threshold_lowerbound,
    '{{ quality_threshold_upperbound }}' as quality_threshold_upperbound

from (
    select {{ column_name }} 
    from {{ model }}
    where {{ column_name }} < 0
    )

{% endmacro %}