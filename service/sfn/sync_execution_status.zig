pub const SyncExecutionStatus = enum {
    succeeded,
    failed,
    timed_out,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
    };
};
