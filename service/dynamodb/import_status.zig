pub const ImportStatus = enum {
    in_progress,
    completed,
    cancelling,
    cancelled,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
