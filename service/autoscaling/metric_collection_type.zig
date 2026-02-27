/// Describes a metric.
pub const MetricCollectionType = struct {
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
    metric: ?[]const u8,
};
