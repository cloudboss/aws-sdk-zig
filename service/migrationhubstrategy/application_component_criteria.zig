pub const ApplicationComponentCriteria = enum {
    not_defined,
    app_name,
    server_id,
    app_type,
    strategy,
    destination,
    analysis_status,
    error_category,

    pub const json_field_names = .{
        .not_defined = "NOT_DEFINED",
        .app_name = "APP_NAME",
        .server_id = "SERVER_ID",
        .app_type = "APP_TYPE",
        .strategy = "STRATEGY",
        .destination = "DESTINATION",
        .analysis_status = "ANALYSIS_STATUS",
        .error_category = "ERROR_CATEGORY",
    };
};
