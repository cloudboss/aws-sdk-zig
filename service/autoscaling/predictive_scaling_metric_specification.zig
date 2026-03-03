const PredictiveScalingCustomizedCapacityMetric = @import("predictive_scaling_customized_capacity_metric.zig").PredictiveScalingCustomizedCapacityMetric;
const PredictiveScalingCustomizedLoadMetric = @import("predictive_scaling_customized_load_metric.zig").PredictiveScalingCustomizedLoadMetric;
const PredictiveScalingCustomizedScalingMetric = @import("predictive_scaling_customized_scaling_metric.zig").PredictiveScalingCustomizedScalingMetric;
const PredictiveScalingPredefinedLoadMetric = @import("predictive_scaling_predefined_load_metric.zig").PredictiveScalingPredefinedLoadMetric;
const PredictiveScalingPredefinedMetricPair = @import("predictive_scaling_predefined_metric_pair.zig").PredictiveScalingPredefinedMetricPair;
const PredictiveScalingPredefinedScalingMetric = @import("predictive_scaling_predefined_scaling_metric.zig").PredictiveScalingPredefinedScalingMetric;

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
///
/// Example
///
/// * You create a predictive scaling policy and specify
/// `ALBRequestCount` as the value for the metric pair and
/// `1000.0` as the target value. For this type of metric, you must
/// provide the metric dimension for the corresponding target group, so you also
/// provide a resource label for the Application Load Balancer target group that
/// is
/// attached to your Auto Scaling group.
///
/// * The number of requests the target group receives per minute provides the
///   load
/// metric, and the request count averaged between the members of the target
/// group
/// provides the scaling metric. In CloudWatch, this refers to the
/// `RequestCount` and `RequestCountPerTarget` metrics,
/// respectively.
///
/// * For optimal use of predictive scaling, you adhere to the best practice of
/// using a dynamic scaling policy to automatically scale between the minimum
/// capacity and maximum capacity in response to real-time changes in resource
/// utilization.
///
/// * Amazon EC2 Auto Scaling consumes data points for the load metric over the
///   last 14 days and
/// creates an hourly load forecast for predictive scaling. (A minimum of 24
/// hours
/// of data is required.)
///
/// * After creating the load forecast, Amazon EC2 Auto Scaling determines when
///   to reduce or
/// increase the capacity of your Auto Scaling group in each hour of the
/// forecast period so
/// that the average number of requests received by each instance is as close to
/// 1000 requests per minute as possible at all times.
///
/// For information about using custom metrics with predictive scaling, see
/// [Advanced predictive scaling policy configurations using custom
/// metrics](https://docs.aws.amazon.com/autoscaling/ec2/userguide/predictive-scaling-customized-metric-specification.html) in
/// the *Amazon EC2 Auto Scaling User Guide*.
pub const PredictiveScalingMetricSpecification = struct {
    /// The customized capacity metric specification.
    customized_capacity_metric_specification: ?PredictiveScalingCustomizedCapacityMetric = null,

    /// The customized load metric specification.
    customized_load_metric_specification: ?PredictiveScalingCustomizedLoadMetric = null,

    /// The customized scaling metric specification.
    customized_scaling_metric_specification: ?PredictiveScalingCustomizedScalingMetric = null,

    /// The predefined load metric specification.
    predefined_load_metric_specification: ?PredictiveScalingPredefinedLoadMetric = null,

    /// The predefined metric pair specification from which Amazon EC2 Auto Scaling
    /// determines the
    /// appropriate scaling metric and load metric to use.
    predefined_metric_pair_specification: ?PredictiveScalingPredefinedMetricPair = null,

    /// The predefined scaling metric specification.
    predefined_scaling_metric_specification: ?PredictiveScalingPredefinedScalingMetric = null,

    /// Specifies the target utilization.
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
