pub const ExperimentReportStatus = enum {
    pending,
    running,
    completed,
    cancelled,
    failed,

    pub const json_field_names = .{
        .pending = "pending",
        .running = "running",
        .completed = "completed",
        .cancelled = "cancelled",
        .failed = "failed",
    };
};
