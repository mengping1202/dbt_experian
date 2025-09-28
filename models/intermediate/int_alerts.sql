{{ pivot_with_snake_case(

    source_table = ref('stg_registered_company_credit'),
    value_column = 'field_value',
    pivot_column = 'full_path',
    group_by_columns = ['experian_model','response_id','created_at'],
    agg_function = 'max', 
    filter_expression = "experian_model = 'Alerts'"

) }} 
