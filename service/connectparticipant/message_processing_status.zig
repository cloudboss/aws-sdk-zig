pub const MessageProcessingStatus = enum {
    processing,
    failed,
    rejected,

    pub const json_field_names = .{
        .processing = "PROCESSING",
        .failed = "FAILED",
        .rejected = "REJECTED",
    };
};
