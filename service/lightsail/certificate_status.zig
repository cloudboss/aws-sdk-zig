pub const CertificateStatus = enum {
    pending_validation,
    issued,
    inactive,
    expired,
    validation_timed_out,
    revoked,
    failed,

    pub const json_field_names = .{
        .pending_validation = "PendingValidation",
        .issued = "Issued",
        .inactive = "Inactive",
        .expired = "Expired",
        .validation_timed_out = "ValidationTimedOut",
        .revoked = "Revoked",
        .failed = "Failed",
    };
};
