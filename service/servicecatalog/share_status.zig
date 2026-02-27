pub const ShareStatus = enum {
    not_started,
    in_progress,
    completed,
    completed_with_errors,
    @"error",

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .completed_with_errors = "COMPLETED_WITH_ERRORS",
        .@"error" = "ERROR",
    };
};
