{% macro test_range(model,column_name,dq_dimension = 'Validity',rule_description = 'To check if the data values are within fixed range. The range can be defined by the user for a specific datatype',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40, upper_limit,lower_limit) %}

select 
    count(*) as validation_errors,
    '{{ dq_dimension }}' as dq_dimension,
    '{{ rule_description }}' as rule_description,
    '{{ quality_threshold_lowerbound }}' as quality_threshold_lowerbound,
    '{{ quality_threshold_upperbound }}' as quality_threshold_upperbound

from (
    select {{ column_name }} 
    from {{ model }}
    where {{ column_name }} NOT BETWEEN lower_limit AND upper_limit
    )

{% endmacro %}