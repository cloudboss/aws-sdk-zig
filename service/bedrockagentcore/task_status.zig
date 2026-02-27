pub const TaskStatus = enum {
    submitted,
    working,
    completed,
    canceled,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .working = "WORKING",
        .completed = "COMPLETED",
        .canceled = "CANCELED",
        .failed = "FAILED",
    };
};
