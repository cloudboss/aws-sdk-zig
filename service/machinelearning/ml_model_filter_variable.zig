pub const MLModelFilterVariable = enum {
    created_at,
    last_updated_at,
    status,
    name,
    iam_user,
    training_datasource_id,
    real_time_endpoint_status,
    ml_model_type,
    algorithm,
    training_data_uri,

    pub const json_field_names = .{
        .created_at = "CREATED_AT",
        .last_updated_at = "LAST_UPDATED_AT",
        .status = "STATUS",
        .name = "NAME",
        .iam_user = "IAM_USER",
        .training_datasource_id = "TRAINING_DATASOURCE_ID",
        .real_time_endpoint_status = "REAL_TIME_ENDPOINT_STATUS",
        .ml_model_type = "ML_MODEL_TYPE",
        .algorithm = "ALGORITHM",
        .training_data_uri = "TRAINING_DATA_URI",
    };
};
