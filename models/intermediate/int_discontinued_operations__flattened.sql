{{ flatten_json_response(

    source_table = ref('int_accounts'),
    response_field = 'discontinued_operations',
    additional_columns = ['response_id', 'created_at', 'date_of_accounts'], 
    experian_model = 'DiscontinuedOperations'

) }}
