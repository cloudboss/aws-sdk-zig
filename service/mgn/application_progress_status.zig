pub const ApplicationProgressStatus = enum {
    not_started,
    in_progress,
    completed,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
    };
};
