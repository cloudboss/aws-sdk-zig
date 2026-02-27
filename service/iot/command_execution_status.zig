pub const CommandExecutionStatus = enum {
    created,
    in_progress,
    succeeded,
    failed,
    rejected,
    timed_out,

    pub const json_field_names = .{
        .created = "CREATED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .rejected = "REJECTED",
        .timed_out = "TIMED_OUT",
    };
};
