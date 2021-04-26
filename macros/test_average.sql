{% macro test_average(model,column_name,value,operator = '=',dq_dimension = 'Validity',rule_description = 'To check the max column value',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

select 
    count(*) as validation_errors from
    (
        select 
            avg_value as avg_value,
            flag as result
        from 
            (select avg({{ column_name }}) as avg_value, case when avg({{ column_name }}) {{ operator }} {{ value }} then 'PASS'
            else 'FAIL' end as flag from {{ model }})
        where flag = 'FAIL'
    )
{% endmacro %}