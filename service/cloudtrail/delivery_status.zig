pub const DeliveryStatus = enum {
    success,
    failed,
    failed_signing_file,
    pending,
    resource_not_found,
    access_denied,
    access_denied_signing_file,
    cancelled,
    unknown,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failed = "FAILED",
        .failed_signing_file = "FAILED_SIGNING_FILE",
        .pending = "PENDING",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .access_denied = "ACCESS_DENIED",
        .access_denied_signing_file = "ACCESS_DENIED_SIGNING_FILE",
        .cancelled = "CANCELLED",
        .unknown = "UNKNOWN",
    };
};
