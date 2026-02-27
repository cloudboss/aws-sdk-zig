pub const AnalyticsIntentMetricName = enum {
    count,
    success,
    failure,
    switched,
    dropped,

    pub const json_field_names = .{
        .count = "Count",
        .success = "Success",
        .failure = "Failure",
        .switched = "Switched",
        .dropped = "Dropped",
    };
};
