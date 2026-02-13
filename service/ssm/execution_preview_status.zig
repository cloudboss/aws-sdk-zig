pub const ExecutionPreviewStatus = enum {
    pending,
    in_progress,
    success,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failed = "FAILED",
    };
};
