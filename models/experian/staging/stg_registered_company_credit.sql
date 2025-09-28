{{ flatten_json_response(

    source_table = source('experian', 'RegisteredCompanyCredit'),
    response_field = 'api_response',
    top_level_fields = ['RegNumber', 'CommercialName'],
    additional_columns = ['response_id', 'request_id', 'created_at'], 
    recursive = true

) }}

