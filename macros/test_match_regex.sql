{% macro test_match_regex(model,column_name,expression,dq_dimension = 'Validity',rule_description = 'To check if the data values match a text or regex pattern',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40,)%}

select 
    count(*) as validation_errors
from (
        select *,{{ column_name }} regexp '{{ expression }}' as matches
            from  {{ model }} 
            where matches = 'FALSE'
    )

{% endmacro %}