pub const LoadBalancerTlsCertificateStatus = enum {
    pending_validation,
    issued,
    inactive,
    expired,
    validation_timed_out,
    revoked,
    failed,
    unknown,

    pub const json_field_names = .{
        .pending_validation = "PendingValidation",
        .issued = "Issued",
        .inactive = "Inactive",
        .expired = "Expired",
        .validation_timed_out = "ValidationTimedOut",
        .revoked = "Revoked",
        .failed = "Failed",
        .unknown = "Unknown",
    };
};
