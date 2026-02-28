pub const TaskStatus = enum {
    finished,
    failed,
    false,

    pub const json_field_names = .{
        .finished = "FINISHED",
        .failed = "FAILED",
        .false = "FALSE",
    };
};
