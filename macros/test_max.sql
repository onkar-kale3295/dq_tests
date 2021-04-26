{% macro test_max(model,column_name,value,operator = '=',dq_dimension = 'Validity',rule_description = 'To check the max column value',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

select 
    max_value as max_value,
    flag as result
from 
    (select max({{ column_name }}) as max_value, case when max({{ column_name }}) {{ operator }} {{ value }} then 'PASS'
     else 'FAIL' end as flag from {{ model }})
where flag = 'FAIL'

{% endmacro %}