pub const DnsRecordVerificationStatus = enum {
    pending,
    verified,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .verified = "VERIFIED",
        .failed = "FAILED",
    };
};
