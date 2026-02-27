pub const DatasetStatusMessageCode = enum {
    success,
    service_error,
    client_error,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .service_error = "SERVICE_ERROR",
        .client_error = "CLIENT_ERROR",
    };
};
