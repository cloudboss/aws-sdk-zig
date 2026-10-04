const aws = @import("aws");

/// Contains metrics and performance indicators from the training of a
/// recommender model.
pub const TrainingMetrics = struct {
    /// A collection of performance metrics and statistics from the training
    /// process.
    metrics: ?[]const aws.map.MapEntry(f64) = null,

    /// The name of the recommender version that produced these training metrics.
    recommender_version_name: ?[]const u8 = null,

    /// The timestamp when these training metrics were recorded.
    time: ?i64 = null,

    pub const json_field_names = .{
        .metrics = "Metrics",
        .recommender_version_name = "RecommenderVersionName",
        .time = "Time",
    };
};
