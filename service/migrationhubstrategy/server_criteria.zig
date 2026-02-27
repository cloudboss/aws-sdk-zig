pub const ServerCriteria = enum {
    not_defined,
    os_name,
    strategy,
    destination,
    server_id,
    analysis_status,
    error_category,

    pub const json_field_names = .{
        .not_defined = "NOT_DEFINED",
        .os_name = "OS_NAME",
        .strategy = "STRATEGY",
        .destination = "DESTINATION",
        .server_id = "SERVER_ID",
        .analysis_status = "ANALYSIS_STATUS",
        .error_category = "ERROR_CATEGORY",
    };
};
