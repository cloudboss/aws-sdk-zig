const ChangeDirectionEnum = @import("change_direction_enum.zig").ChangeDirectionEnum;
const MetricDefinition = @import("metric_definition.zig").MetricDefinition;

/// A structure that tells Evidently whether higher or lower values are desired
/// for a metric that is used in an experiment.
pub const MetricGoal = struct {
    /// `INCREASE` means that a variation with a higher number for this metric is
    /// performing better.
    ///
    /// `DECREASE` means that a variation with a lower number for this metric is
    /// performing better.
    desired_change: ?ChangeDirectionEnum,

    /// A structure that contains details about the metric.
    metric_definition: MetricDefinition,

    pub const json_field_names = .{
        .desired_change = "desiredChange",
        .metric_definition = "metricDefinition",
    };
};
