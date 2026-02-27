pub const LabelRating = enum {
    anomaly,
    no_anomaly,
    neutral,

    pub const json_field_names = .{
        .anomaly = "ANOMALY",
        .no_anomaly = "NO_ANOMALY",
        .neutral = "NEUTRAL",
    };
};
