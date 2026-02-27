pub const ServiceQuotaExceededExceptionReason = enum {
    service_quota_exceeded_exception,
    kms_key_limit_exceeded,
    dependency_limit_exceeded,

    pub const json_field_names = .{
        .service_quota_exceeded_exception = "SERVICE_QUOTA_EXCEEDED_EXCEPTION",
        .kms_key_limit_exceeded = "KMS_KEY_LIMIT_EXCEEDED",
        .dependency_limit_exceeded = "DEPENDENCY_LIMIT_EXCEEDED",
    };
};
