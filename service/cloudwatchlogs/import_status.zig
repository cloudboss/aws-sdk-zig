pub const ImportStatus = enum {
    in_progress,
    cancelled,
    completed,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .cancelled = "CANCELLED",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
