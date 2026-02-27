pub const DomainNameStatus = enum {
    available,
    updating,
    pending,
    pending_certificate_reimport,
    pending_ownership_verification,
    failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .updating = "UPDATING",
        .pending = "PENDING",
        .pending_certificate_reimport = "PENDING_CERTIFICATE_REIMPORT",
        .pending_ownership_verification = "PENDING_OWNERSHIP_VERIFICATION",
        .failed = "FAILED",
    };
};
