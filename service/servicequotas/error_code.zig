pub const ErrorCode = enum {
    dependency_access_denied_error,
    dependency_throttling_error,
    dependency_service_error,
    service_quota_not_available_error,

    pub const json_field_names = .{
        .dependency_access_denied_error = "DEPENDENCY_ACCESS_DENIED_ERROR",
        .dependency_throttling_error = "DEPENDENCY_THROTTLING_ERROR",
        .dependency_service_error = "DEPENDENCY_SERVICE_ERROR",
        .service_quota_not_available_error = "SERVICE_QUOTA_NOT_AVAILABLE_ERROR",
    };
};
