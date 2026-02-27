pub const TestExecutionStatus = enum {
    succeeded,
    failed,
    retriable,
    caught_error,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .retriable = "RETRIABLE",
        .caught_error = "CAUGHT_ERROR",
    };
};
