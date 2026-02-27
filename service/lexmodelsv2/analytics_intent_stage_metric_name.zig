pub const AnalyticsIntentStageMetricName = enum {
    count,
    success,
    failed,
    dropped,
    retry,

    pub const json_field_names = .{
        .count = "Count",
        .success = "Success",
        .failed = "Failed",
        .dropped = "Dropped",
        .retry = "Retry",
    };
};
