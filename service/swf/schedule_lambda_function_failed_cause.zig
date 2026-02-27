pub const ScheduleLambdaFunctionFailedCause = enum {
    id_already_in_use,
    open_lambda_functions_limit_exceeded,
    lambda_function_creation_rate_exceeded,
    lambda_service_not_available_in_region,

    pub const json_field_names = .{
        .id_already_in_use = "ID_ALREADY_IN_USE",
        .open_lambda_functions_limit_exceeded = "OPEN_LAMBDA_FUNCTIONS_LIMIT_EXCEEDED",
        .lambda_function_creation_rate_exceeded = "LAMBDA_FUNCTION_CREATION_RATE_EXCEEDED",
        .lambda_service_not_available_in_region = "LAMBDA_SERVICE_NOT_AVAILABLE_IN_REGION",
    };
};
