pub const ExportState = enum {
    queued,
    preprocessing,
    processing,
    completed,
    failed,
    cancelled,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .preprocessing = "PREPROCESSING",
        .processing = "PROCESSING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };
};
