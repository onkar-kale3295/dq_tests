{% macro test_std_deviation(model,column_name,value,operator = '=',dq_dimension = 'Validity',rule_description = 'To check the max column value',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

select 
    count(*) as validation_errors from
    (
        select 
            std_deviation as std_deviation,
            flag as result
        from 
            (select STDDEV({{ column_name }}) as std_deviation, case when STDDEV({{ column_name }}) {{ operator }} {{ value }} then 'PASS'
            else 'FAIL' end as flag from {{ model }})
        where flag = 'FAIL'
    )
{% endmacro %}