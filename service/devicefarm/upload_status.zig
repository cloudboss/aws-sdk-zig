pub const UploadStatus = enum {
    initialized,
    processing,
    succeeded,
    failed,

    pub const json_field_names = .{
        .initialized = "INITIALIZED",
        .processing = "PROCESSING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
