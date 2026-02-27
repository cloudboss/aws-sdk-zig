pub const ExecutionStatus = enum {
    failed,
    started,

    pub const json_field_names = .{
        .failed = "FAILED",
        .started = "STARTED",
    };
};
