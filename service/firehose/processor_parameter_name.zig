pub const ProcessorParameterName = enum {
    lambda_arn,
    lambda_number_of_retries,
    metadata_extraction_query,
    json_parsing_engine,
    role_arn,
    buffer_size_in_mb,
    buffer_interval_in_seconds,
    sub_record_type,
    delimiter,
    compression_format,
    data_message_extraction,

    pub const json_field_names = .{
        .lambda_arn = "LAMBDA_ARN",
        .lambda_number_of_retries = "LAMBDA_NUMBER_OF_RETRIES",
        .metadata_extraction_query = "METADATA_EXTRACTION_QUERY",
        .json_parsing_engine = "JSON_PARSING_ENGINE",
        .role_arn = "ROLE_ARN",
        .buffer_size_in_mb = "BUFFER_SIZE_IN_MB",
        .buffer_interval_in_seconds = "BUFFER_INTERVAL_IN_SECONDS",
        .sub_record_type = "SUB_RECORD_TYPE",
        .delimiter = "Delimiter",
        .compression_format = "COMPRESSION_FORMAT",
        .data_message_extraction = "DATA_MESSAGE_EXTRACTION",
    };
};
