const MetricType = @import("metric_type.zig").MetricType;

/// Represents a predefined metric for a target tracking scaling policy to use
/// with
/// Application Auto Scaling.
///
/// For more information, [Predefined metrics for target tracking scaling
/// policies](https://docs.aws.amazon.com/autoscaling/application/userguide/monitoring-cloudwatch.html#predefined-metrics) in the
/// *Application Auto Scaling User Guide*.
pub const PredefinedMetricSpecification = struct {
    /// The metric type. The `ALBRequestCountPerTarget` metric type applies only to
    /// Spot Fleets and ECS services.
    predefined_metric_type: MetricType,

    /// Identifies the resource associated with the metric type. You can't specify a
    /// resource
    /// label unless the metric type is `ALBRequestCountPerTarget` and there is a
    /// target
    /// group attached to the Spot Fleet or ECS service.
    ///
    /// You create the resource label by appending the final portion of the load
    /// balancer ARN
    /// and the final portion of the target group ARN into a single value, separated
    /// by a forward
    /// slash (/). The format of the resource label is:
    ///
    /// `app/my-alb/778d41231b141a0f/targetgroup/my-alb-target-group/943f017f100becff`.
    ///
    /// Where:
    ///
    /// * app// is the final portion of
    /// the load balancer ARN
    ///
    /// * targetgroup// is the final portion
    /// of the target group ARN.
    ///
    /// To find the ARN for an Application Load Balancer, use the
    /// [DescribeLoadBalancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html) API operation. To find the ARN for the target group, use
    /// the
    /// [DescribeTargetGroups](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeTargetGroups.html) API operation.
    resource_label: ?[]const u8,

    pub const json_field_names = .{
        .predefined_metric_type = "PredefinedMetricType",
        .resource_label = "ResourceLabel",
    };
};
