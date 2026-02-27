pub const ReferenceStatus = enum {
    available,
    deleted,
    approved,
    rejected,
    processing,
    failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .deleted = "DELETED",
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .processing = "PROCESSING",
        .failed = "FAILED",
    };
};
