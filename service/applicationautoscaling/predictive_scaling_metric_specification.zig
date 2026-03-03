const PredictiveScalingCustomizedMetricSpecification = @import("predictive_scaling_customized_metric_specification.zig").PredictiveScalingCustomizedMetricSpecification;
const PredictiveScalingPredefinedLoadMetricSpecification = @import("predictive_scaling_predefined_load_metric_specification.zig").PredictiveScalingPredefinedLoadMetricSpecification;
const PredictiveScalingPredefinedMetricPairSpecification = @import("predictive_scaling_predefined_metric_pair_specification.zig").PredictiveScalingPredefinedMetricPairSpecification;
const PredictiveScalingPredefinedScalingMetricSpecification = @import("predictive_scaling_predefined_scaling_metric_specification.zig").PredictiveScalingPredefinedScalingMetricSpecification;

/// This structure specifies the metrics and target utilization settings for a
/// predictive
/// scaling policy.
///
/// You must specify either a metric pair, or a load metric and a scaling metric
/// individually. Specifying a metric pair instead of individual metrics
/// provides a simpler
/// way to configure metrics for a scaling policy. You choose the metric pair,
/// and the
/// policy automatically knows the correct sum and average statistics to use for
/// the load
/// metric and the scaling metric.
pub const PredictiveScalingMetricSpecification = struct {
    /// The customized capacity metric specification.
    customized_capacity_metric_specification: ?PredictiveScalingCustomizedMetricSpecification = null,

    /// The customized load metric specification.
    customized_load_metric_specification: ?PredictiveScalingCustomizedMetricSpecification = null,

    /// The customized scaling metric specification.
    customized_scaling_metric_specification: ?PredictiveScalingCustomizedMetricSpecification = null,

    /// The predefined load metric specification.
    predefined_load_metric_specification: ?PredictiveScalingPredefinedLoadMetricSpecification = null,

    /// The predefined metric pair specification that determines the appropriate
    /// scaling metric and load metric to use.
    predefined_metric_pair_specification: ?PredictiveScalingPredefinedMetricPairSpecification = null,

    /// The predefined scaling metric specification.
    predefined_scaling_metric_specification: ?PredictiveScalingPredefinedScalingMetricSpecification = null,

    /// Specifies the target utilization.
    target_value: f64,

    pub const json_field_names = .{
        .customized_capacity_metric_specification = "CustomizedCapacityMetricSpecification",
        .customized_load_metric_specification = "CustomizedLoadMetricSpecification",
        .customized_scaling_metric_specification = "CustomizedScalingMetricSpecification",
        .predefined_load_metric_specification = "PredefinedLoadMetricSpecification",
        .predefined_metric_pair_specification = "PredefinedMetricPairSpecification",
        .predefined_scaling_metric_specification = "PredefinedScalingMetricSpecification",
        .target_value = "TargetValue",
    };
};
