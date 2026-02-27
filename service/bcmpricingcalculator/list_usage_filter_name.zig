pub const ListUsageFilterName = enum {
    usage_account_id,
    service_code,
    usage_type,
    operation,
    location,
    usage_group,
    historical_usage_account_id,
    historical_service_code,
    historical_usage_type,
    historical_operation,
    historical_location,

    pub const json_field_names = .{
        .usage_account_id = "USAGE_ACCOUNT_ID",
        .service_code = "SERVICE_CODE",
        .usage_type = "USAGE_TYPE",
        .operation = "OPERATION",
        .location = "LOCATION",
        .usage_group = "USAGE_GROUP",
        .historical_usage_account_id = "HISTORICAL_USAGE_ACCOUNT_ID",
        .historical_service_code = "HISTORICAL_SERVICE_CODE",
        .historical_usage_type = "HISTORICAL_USAGE_TYPE",
        .historical_operation = "HISTORICAL_OPERATION",
        .historical_location = "HISTORICAL_LOCATION",
    };
};
