pub const SessionsStatisticsAggregationStatus = enum {
    in_progress,
    timeout,
    failed,
    completed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .timeout = "TIMEOUT",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};
