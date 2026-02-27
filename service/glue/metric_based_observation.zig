const DataQualityMetricValues = @import("data_quality_metric_values.zig").DataQualityMetricValues;

/// Describes the metric based observation generated based on evaluated data
/// quality metrics.
pub const MetricBasedObservation = struct {
    /// The name of the data quality metric used for generating the observation.
    metric_name: ?[]const u8,

    /// An object of type `DataQualityMetricValues` representing the analysis of the
    /// data quality metric value.
    metric_values: ?DataQualityMetricValues,

    /// A list of new data quality rules generated as part of the observation based
    /// on the data quality metric value.
    new_rules: ?[]const []const u8,

    /// The Statistic ID.
    statistic_id: ?[]const u8,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .metric_values = "MetricValues",
        .new_rules = "NewRules",
        .statistic_id = "StatisticId",
    };
};
