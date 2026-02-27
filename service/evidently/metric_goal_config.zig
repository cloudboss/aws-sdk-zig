const ChangeDirectionEnum = @import("change_direction_enum.zig").ChangeDirectionEnum;
const MetricDefinitionConfig = @import("metric_definition_config.zig").MetricDefinitionConfig;

/// Use this structure to tell Evidently whether higher or lower values are
/// desired for a metric that is used in an experiment.
pub const MetricGoalConfig = struct {
    /// `INCREASE` means that a variation with a higher number for this metric is
    /// performing better.
    ///
    /// `DECREASE` means that a variation with a lower number for this metric is
    /// performing better.
    desired_change: ?ChangeDirectionEnum,

    /// A structure that contains details about the metric.
    metric_definition: MetricDefinitionConfig,

    pub const json_field_names = .{
        .desired_change = "desiredChange",
        .metric_definition = "metricDefinition",
    };
};
