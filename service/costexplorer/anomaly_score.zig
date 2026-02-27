/// Quantifies the anomaly. The higher score means that it's more anomalous.
pub const AnomalyScore = struct {
    /// The last observed score.
    current_score: f64 = 0,

    /// The maximum score that's observed during the `AnomalyDateInterval`.
    max_score: f64 = 0,

    pub const json_field_names = .{
        .current_score = "CurrentScore",
        .max_score = "MaxScore",
    };
};
