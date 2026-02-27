pub const AnalyticsUtteranceMetricName = enum {
    count,
    missed,
    detected,
    utterance_timestamp,

    pub const json_field_names = .{
        .count = "Count",
        .missed = "Missed",
        .detected = "Detected",
        .utterance_timestamp = "UtteranceTimestamp",
    };
};
