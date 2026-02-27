const CustomizedMetricSpecification = @import("customized_metric_specification.zig").CustomizedMetricSpecification;
const PredefinedMetricSpecification = @import("predefined_metric_specification.zig").PredefinedMetricSpecification;

/// Represents a target tracking scaling policy configuration to use with Amazon
/// EC2 Auto Scaling.
pub const TargetTrackingConfiguration = struct {
    /// A customized metric. You must specify either a predefined metric or a
    /// customized
    /// metric.
    customized_metric_specification: ?CustomizedMetricSpecification,

    /// Indicates whether scaling in by the target tracking scaling policy is
    /// disabled. If
    /// scaling in is disabled, the target tracking scaling policy doesn't remove
    /// instances from
    /// the Auto Scaling group. Otherwise, the target tracking scaling policy can
    /// remove instances from
    /// the Auto Scaling group. The default is `false`.
    disable_scale_in: ?bool,

    /// A predefined metric. You must specify either a predefined metric or a
    /// customized
    /// metric.
    predefined_metric_specification: ?PredefinedMetricSpecification,

    /// The target value for the metric.
    ///
    /// Some metrics are based on a count instead of a percentage, such as the
    /// request
    /// count for an Application Load Balancer or the number of messages in an SQS
    /// queue. If the scaling policy
    /// specifies one of these metrics, specify the target utilization as the
    /// optimal
    /// average request or message count per instance during any one-minute
    /// interval.
    target_value: f64,
};
