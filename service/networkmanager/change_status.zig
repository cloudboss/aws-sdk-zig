pub const ChangeStatus = enum {
    not_started,
    in_progress,
    complete,
    failed,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
    };
};
