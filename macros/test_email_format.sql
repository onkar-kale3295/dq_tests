{% macro test_email_format(model,column_name,dq_dimension = 'Accuracy',rule_description = 'To check the email format against accepatable format',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40,expression = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')%}

select 
    count(*) as validation_errors,
    '{{ dq_dimension }}' as dq_dimension,
    '{{ rule_description }}' as rule_description,
    '{{ quality_threshold_lowerbound }}' as quality_threshold_lowerbound,
    '{{ quality_threshold_upperbound }}' as quality_threshold_upperbound
from (
        select {{ column_name }} regexp '{{ expression }}' as matches
            from  {{ model }} 
            where matches = 'FALSE'
    )

{% endmacro %}