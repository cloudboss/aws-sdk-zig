pub const UsageReportExecutionErrorCode = enum {
    resource_not_found,
    access_denied,
    internal_service_error,

    pub const json_field_names = .{
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .access_denied = "ACCESS_DENIED",
        .internal_service_error = "INTERNAL_SERVICE_ERROR",
    };
};
