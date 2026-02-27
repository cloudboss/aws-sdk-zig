pub const CertificateValidationRecordStatus = enum {
    pending_validation,
    success,
    failed,

    pub const json_field_names = .{
        .pending_validation = "PENDING_VALIDATION",
        .success = "SUCCESS",
        .failed = "FAILED",
    };
};
