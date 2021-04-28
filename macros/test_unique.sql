{% macro test_unique(model,column_name,dq_dimension = 'Uniqueness',rule_description = 'To check if the column has unique values',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

select 
    count(*) as validation_errors
from (

    select
        {{ column_name }}
    from {{ model }}
    where {{ column_name }} is not null
    group by {{ column_name }}
    having count(*) > 1
    )

{% endmacro %}