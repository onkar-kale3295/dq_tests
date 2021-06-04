{% macro test_outlier_single_column (model,column_name,upper_limit,lower_limit,dq_dimension = 'Validity',rule_description = 'To check if the data values are within fixed range. The range can be defined by the user for a specific datatype',quality_threshold_upperbound = 80,quality_threshold_lowerbound = 40) %}

select 
    count(*) as validation_errors
from (
    select * 
    from {{ model }}
    where {{ column_name }} NOT BETWEEN {{ lower_limit }} AND {{ upper_limit }}
    )

{% endmacro %}