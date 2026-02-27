pub const JobErrorCode = enum {
    authorization_error,
    resource_not_found_error,
    service_quota_exceeded_error,
    service_error,

    pub const json_field_names = .{
        .authorization_error = "AUTHORIZATION_ERROR",
        .resource_not_found_error = "RESOURCE_NOT_FOUND_ERROR",
        .service_quota_exceeded_error = "SERVICE_QUOTA_EXCEEDED_ERROR",
        .service_error = "SERVICE_ERROR",
    };
};
