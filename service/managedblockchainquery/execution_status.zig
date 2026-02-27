pub const ExecutionStatus = enum {
    failed,
    succeeded,

    pub const json_field_names = .{
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
    };
};
