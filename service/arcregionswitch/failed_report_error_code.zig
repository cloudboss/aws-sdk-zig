pub const FailedReportErrorCode = enum {
    insufficient_permissions,
    invalid_resource,
    configuration_error,

    pub const json_field_names = .{
        .insufficient_permissions = "INSUFFICIENT_PERMISSIONS",
        .invalid_resource = "INVALID_RESOURCE",
        .configuration_error = "CONFIGURATION_ERROR",
    };
};
