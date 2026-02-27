pub const CaseAttachmentStatus = enum {
    verified,
    failed,
    pending,

    pub const json_field_names = .{
        .verified = "VERIFIED",
        .failed = "FAILED",
        .pending = "PENDING",
    };
};
