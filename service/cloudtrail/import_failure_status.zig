pub const ImportFailureStatus = enum {
    failed,
    retry,
    succeeded,

    pub const json_field_names = .{
        .failed = "FAILED",
        .retry = "RETRY",
        .succeeded = "SUCCEEDED",
    };
};
