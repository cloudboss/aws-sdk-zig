/// Changeset Error Category
pub const ErrorCategory = enum {
    validation,
    service_quota_exceeded,
    access_denied,
    resource_not_found,
    throttling,
    internal_service_exception,
    cancelled,
    user_recoverable,

    pub const json_field_names = .{
        .validation = "VALIDATION",
        .service_quota_exceeded = "SERVICE_QUOTA_EXCEEDED",
        .access_denied = "ACCESS_DENIED",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .throttling = "THROTTLING",
        .internal_service_exception = "INTERNAL_SERVICE_EXCEPTION",
        .cancelled = "CANCELLED",
        .user_recoverable = "USER_RECOVERABLE",
    };
};
