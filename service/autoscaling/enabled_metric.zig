/// Describes an enabled Auto Scaling group metric.
pub const EnabledMetric = struct {
    /// The granularity of the metric. The only valid value is `1Minute`.
    granularity: ?[]const u8 = null,

    /// One of the following metrics:
    ///
    /// * `GroupMinSize`
    ///
    /// * `GroupMaxSize`
    ///
    /// * `GroupDesiredCapacity`
    ///
    /// * `GroupInServiceInstances`
    ///
    /// * `GroupPendingInstances`
    ///
    /// * `GroupStandbyInstances`
    ///
    /// * `GroupTerminatingInstances`
    ///
    /// * `GroupTotalInstances`
    ///
    /// * `GroupInServiceCapacity`
    ///
    /// * `GroupPendingCapacity`
    ///
    /// * `GroupStandbyCapacity`
    ///
    /// * `GroupTerminatingCapacity`
    ///
    /// * `GroupTotalCapacity`
    ///
    /// * `WarmPoolDesiredCapacity`
    ///
    /// * `WarmPoolWarmedCapacity`
    ///
    /// * `WarmPoolPendingCapacity`
    ///
    /// * `WarmPoolTerminatingCapacity`
    ///
    /// * `WarmPoolTotalCapacity`
    ///
    /// * `GroupAndWarmPoolDesiredCapacity`
    ///
    /// * `GroupAndWarmPoolTotalCapacity`
    ///
    /// For more information, see [Amazon CloudWatch metrics for
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-metrics.html) in the *Amazon EC2 Auto Scaling User Guide*.
    metric: ?[]const u8 = null,
};
