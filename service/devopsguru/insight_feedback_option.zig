pub const InsightFeedbackOption = enum {
    valid_collection,
    recommendation_useful,
    alert_too_sensitive,
    data_noisy_anomaly,
    data_incorrect,

    pub const json_field_names = .{
        .valid_collection = "VALID_COLLECTION",
        .recommendation_useful = "RECOMMENDATION_USEFUL",
        .alert_too_sensitive = "ALERT_TOO_SENSITIVE",
        .data_noisy_anomaly = "DATA_NOISY_ANOMALY",
        .data_incorrect = "DATA_INCORRECT",
    };
};
