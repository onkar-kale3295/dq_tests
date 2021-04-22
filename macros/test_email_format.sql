{% macro test_email_format(model,column_name,dq_dimension = 'Accuracy',rule_description = 'To check the email format against accepatable format',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40,expression = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')%}

select 
    count(*) as validation_errors
from (
        select {{ column_name }} regexp '{{ expression }}' as matches
            from  {{ model }} 
            where matches = 'FALSE'
    )

{% endmacro %}