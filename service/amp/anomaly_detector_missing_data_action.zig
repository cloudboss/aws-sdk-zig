/// Specifies the action to take when data is missing during anomaly detection
/// evaluation.
pub const AnomalyDetectorMissingDataAction = union(enum) {
    /// Marks missing data points as anomalies.
    mark_as_anomaly: ?bool,
    /// Skips evaluation when data is missing.
    skip: ?bool,

    pub const json_field_names = .{
        .mark_as_anomaly = "markAsAnomaly",
        .skip = "skip",
    };
};
