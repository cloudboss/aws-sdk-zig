const MetricSpecification = @import("metric_specification.zig").MetricSpecification;

/// A target tracking scaling policy. Includes support for predefined or
/// customized metrics.
///
/// When using the
/// [PutScalingPolicy](https://docs.aws.amazon.com/autoscaling/application/APIReference/API_PutScalingPolicy.html) API, this parameter is required when you are creating a policy with the policy type `TargetTrackingScaling`.
pub const TargetTrackingScalingPolicyConfiguration = struct {
    /// An object containing information about a metric.
    metric_specification: ?MetricSpecification = null,

    /// The recommended target value to specify for the metric when creating a
    /// scaling policy.
    target_value: ?f64 = null,

    pub const json_field_names = .{
        .metric_specification = "MetricSpecification",
        .target_value = "TargetValue",
    };
};
