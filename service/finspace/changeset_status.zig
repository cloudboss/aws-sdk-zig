pub const ChangesetStatus = enum {
    pending,
    processing,
    failed,
    completed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .processing = "PROCESSING",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};
