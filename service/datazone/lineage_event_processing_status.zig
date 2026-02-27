pub const LineageEventProcessingStatus = enum {
    requested,
    processing,
    success,
    failed,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .processing = "PROCESSING",
        .success = "SUCCESS",
        .failed = "FAILED",
    };
};
