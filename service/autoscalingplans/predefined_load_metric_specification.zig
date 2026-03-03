const LoadMetricType = @import("load_metric_type.zig").LoadMetricType;

/// Represents a predefined metric that can be used for predictive scaling.
///
/// After creating your scaling plan, you can use the AWS Auto Scaling console
/// to visualize
/// forecasts for the specified metric. For more information, see [View
/// Scaling Information for a
/// Resource](https://docs.aws.amazon.com/autoscaling/plans/userguide/gs-create-scaling-plan.html#gs-view-resource) in the
/// *AWS Auto Scaling User Guide*.
pub const PredefinedLoadMetricSpecification = struct {
    /// The metric type.
    predefined_load_metric_type: LoadMetricType,

    /// Identifies the resource associated with the metric type. You can't specify a
    /// resource
    /// label unless the metric type is `ALBTargetGroupRequestCount` and there is a
    /// target group for an Application Load Balancer attached to the Auto Scaling
    /// group.
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
    resource_label: ?[]const u8 = null,

    pub const json_field_names = .{
        .predefined_load_metric_type = "PredefinedLoadMetricType",
        .resource_label = "ResourceLabel",
    };
};
