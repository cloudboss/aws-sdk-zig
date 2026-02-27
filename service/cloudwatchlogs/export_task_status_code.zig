pub const ExportTaskStatusCode = enum {
    cancelled,
    completed,
    failed,
    pending,
    pending_cancel,
    running,

    pub const json_field_names = .{
        .cancelled = "CANCELLED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .pending = "PENDING",
        .pending_cancel = "PENDING_CANCEL",
        .running = "RUNNING",
    };
};
