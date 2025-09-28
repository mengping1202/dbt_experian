{{ pivot_with_snake_case(

    source_table = ref('int_disclosure_items__flattened'),
    value_column = 'field_value',
    pivot_column = 'full_path',
    group_by_columns = ['experian_model','response_id','created_at', 'date_of_accounts'],
    agg_function = 'max'

) }} 