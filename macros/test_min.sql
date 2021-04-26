{% macro test_min(model,column_name,value,operator = '=',dq_dimension = 'Validity',rule_description = 'To check the min column value',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

select 
    min_value as min_value,
    flag as result
from 
    (select min({{ column_name }}) as min_value, case when min({{ column_name }}) {{ operator }} {{ value }} then 'PASS'
     else 'FAIL' end as flag from {{ model }})
where flag = 'FAIL'

{% endmacro %}