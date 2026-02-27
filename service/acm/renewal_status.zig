pub const RenewalStatus = enum {
    pending_auto_renewal,
    pending_validation,
    success,
    failed,

    pub const json_field_names = .{
        .pending_auto_renewal = "PENDING_AUTO_RENEWAL",
        .pending_validation = "PENDING_VALIDATION",
        .success = "SUCCESS",
        .failed = "FAILED",
    };
};
