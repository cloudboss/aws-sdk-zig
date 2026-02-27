pub const AsyncInvokeStatus = enum {
    in_progress,
    completed,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
