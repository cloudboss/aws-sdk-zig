const ScalingMetricType = @import("scaling_metric_type.zig").ScalingMetricType;

/// Represents a predefined metric that can be used for dynamic scaling as part
/// of a target
/// tracking scaling policy.
pub const PredefinedScalingMetricSpecification = struct {
    /// The metric type. The `ALBRequestCountPerTarget` metric type applies only to
    /// Auto Scaling groups, Spot Fleet requests, and ECS services.
    predefined_scaling_metric_type: ScalingMetricType,

    /// Identifies the resource associated with the metric type. You can't specify a
    /// resource
    /// label unless the metric type is `ALBRequestCountPerTarget` and there is a
    /// target
    /// group for an Application Load Balancer attached to the Auto Scaling group,
    /// Spot Fleet request, or
    /// ECS service.
    ///
    /// You create the resource label by appending the final portion of the load
    /// balancer ARN
    /// and the final portion of the target group ARN into a single value, separated
    /// by a forward
    /// slash (/). The format is
    /// app///targetgroup//,
    /// where:
    ///
    /// * app// is the final portion of
    /// the load balancer ARN
    ///
    /// * targetgroup// is the final portion
    /// of the target group ARN.
    ///
    /// This is an example:
    /// app/EC2Co-EcsEl-1TKLTMITMM0EO/f37c06a68c1748aa/targetgroup/EC2Co-Defau-LDNM7Q3ZH1ZN/6d4ea56ca2d6a18d.
    ///
    /// To find the ARN for an Application Load Balancer, use the
    /// [DescribeLoadBalancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html) API operation. To find the ARN for the target group, use
    /// the
    /// [DescribeTargetGroups](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeTargetGroups.html) API operation.
    resource_label: ?[]const u8,

    pub const json_field_names = .{
        .predefined_scaling_metric_type = "PredefinedScalingMetricType",
        .resource_label = "ResourceLabel",
    };
};
