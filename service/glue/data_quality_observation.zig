const MetricBasedObservation = @import("metric_based_observation.zig").MetricBasedObservation;

/// Describes the observation generated after evaluating the rules and
/// analyzers.
pub const DataQualityObservation = struct {
    /// A description of the data quality observation.
    description: ?[]const u8,

    /// An object of type `MetricBasedObservation` representing the observation that
    /// is based on evaluated data quality metrics.
    metric_based_observation: ?MetricBasedObservation,

    pub const json_field_names = .{
        .description = "Description",
        .metric_based_observation = "MetricBasedObservation",
    };
};
