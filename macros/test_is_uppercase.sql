{% macro test_is_uppercase(model,column_name,dq_dimension = 'Accuracy',rule_description = 'To check tif the column values are in Upper Case',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40)%}

select 
    count(*) as validation_errors
from (
        select *,{{ column_name }} regexp '^[A-Z0-9]+' as matches
            from  {{ model }} 
            where matches = 'FALSE'
    )

{% endmacro %}