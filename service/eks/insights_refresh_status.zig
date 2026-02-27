pub const InsightsRefreshStatus = enum {
    in_progress,
    failed,
    completed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};
