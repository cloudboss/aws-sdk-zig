pub const AnalyticsSessionMetricName = enum {
    count,
    success,
    failure,
    dropped,
    duration,
    turns_per_conversation,
    concurrency,

    pub const json_field_names = .{
        .count = "Count",
        .success = "Success",
        .failure = "Failure",
        .dropped = "Dropped",
        .duration = "Duration",
        .turns_per_conversation = "TurnsPerConversation",
        .concurrency = "Concurrency",
    };
};
