pub const FileStatusType = enum {
    approved,
    rejected,
    processing,
    failed,

    pub const json_field_names = .{
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .processing = "PROCESSING",
        .failed = "FAILED",
    };
};
