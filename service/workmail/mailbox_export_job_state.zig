pub const MailboxExportJobState = enum {
    running,
    completed,
    failed,
    cancelled,

    pub const json_field_names = .{
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };
};
