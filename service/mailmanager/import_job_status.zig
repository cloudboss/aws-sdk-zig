pub const ImportJobStatus = enum {
    created,
    processing,
    completed,
    failed,
    stopped,

    pub const json_field_names = .{
        .created = "CREATED",
        .processing = "PROCESSING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };
};
