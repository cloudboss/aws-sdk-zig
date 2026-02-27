pub const ManagedCertificateStatus = enum {
    pending_validation,
    issued,
    inactive,
    expired,
    validation_timed_out,
    revoked,
    failed,
};
