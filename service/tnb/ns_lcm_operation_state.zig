pub const NsLcmOperationState = enum {
    processing,
    completed,
    failed,
    cancelling,
    cancelled,

    pub const json_field_names = .{
        .processing = "PROCESSING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
    };
};
