pub const Status = enum {
    in_progress,
    completed,
    failed,
    cancelled,
    cancelling,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .completed = "Completed",
        .failed = "Failed",
        .cancelled = "Cancelled",
        .cancelling = "Cancelling",
    };
};
