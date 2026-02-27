pub const ServiceQuotaExceededExceptionReason = enum {
    dependency_service_quota_exceeded,

    pub const json_field_names = .{
        .dependency_service_quota_exceeded = "DEPENDENCY_SERVICE_QUOTA_EXCEEDED",
    };
};
