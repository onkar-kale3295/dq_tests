{% macro test_not_null(model,column_name,dq_dimension = 'Completeness',rule_description = 'To check if the column has any null values',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

select 
    count(*) as validation_errors

from (
    select * 
    from {{ model }}
    where {{ column_name }} is null
    )

{% endmacro %}