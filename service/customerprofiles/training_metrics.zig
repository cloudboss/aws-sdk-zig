const aws = @import("aws");

/// Contains metrics and performance indicators from the training of a
/// recommender model.
pub const TrainingMetrics = struct {
    /// A collection of performance metrics and statistics from the training
    /// process.
    metrics: ?[]const aws.map.MapEntry(f64),

    /// The timestamp when these training metrics were recorded.
    time: ?i64,

    pub const json_field_names = .{
        .metrics = "Metrics",
        .time = "Time",
    };
};
