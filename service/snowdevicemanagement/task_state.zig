pub const TaskState = enum {
    in_progress,
    canceled,
    completed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .canceled = "CANCELED",
        .completed = "COMPLETED",
    };
};
