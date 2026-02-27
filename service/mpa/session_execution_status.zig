pub const SessionExecutionStatus = enum {
    executed,
    failed,
    pending,

    pub const json_field_names = .{
        .executed = "EXECUTED",
        .failed = "FAILED",
        .pending = "PENDING",
    };
};
