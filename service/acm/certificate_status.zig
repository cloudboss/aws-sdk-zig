pub const CertificateStatus = enum {
    pending_validation,
    issued,
    inactive,
    expired,
    validation_timed_out,
    revoked,
    failed,

    pub const json_field_names = .{
        .pending_validation = "PENDING_VALIDATION",
        .issued = "ISSUED",
        .inactive = "INACTIVE",
        .expired = "EXPIRED",
        .validation_timed_out = "VALIDATION_TIMED_OUT",
        .revoked = "REVOKED",
        .failed = "FAILED",
    };
};
