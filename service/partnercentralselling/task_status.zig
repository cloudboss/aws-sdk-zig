pub const TaskStatus = enum {
    in_progress,
    complete,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
    };
};
