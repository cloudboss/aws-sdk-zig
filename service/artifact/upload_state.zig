pub const UploadState = enum {
    processing,
    complete,
    failed,
    fault,

    pub const json_field_names = .{
        .processing = "PROCESSING",
        .complete = "COMPLETE",
        .failed = "FAILED",
        .fault = "FAULT",
    };
};
