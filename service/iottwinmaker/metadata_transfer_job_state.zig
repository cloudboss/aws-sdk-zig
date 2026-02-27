pub const MetadataTransferJobState = enum {
    validating,
    pending,
    running,
    cancelling,
    @"error",
    completed,
    cancelled,

    pub const json_field_names = .{
        .validating = "VALIDATING",
        .pending = "PENDING",
        .running = "RUNNING",
        .cancelling = "CANCELLING",
        .@"error" = "ERROR",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
    };
};
