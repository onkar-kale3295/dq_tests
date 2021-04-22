{% macro test_custom_br(model,column_name,br_sql,dq_dimension = 'Validity',rule_description = 'To check validity of data against business rules',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

select 
    count(*) as validation_errors
    
from (
    {{ br_sql }}
    )

{% endmacro %}