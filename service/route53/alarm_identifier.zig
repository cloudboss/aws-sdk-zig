const CloudWatchRegion = @import("cloud_watch_region.zig").CloudWatchRegion;

/// A complex type that identifies the CloudWatch alarm that you want Amazon
/// Route 53
/// health checkers to use to determine whether the specified health check is
/// healthy.
pub const AlarmIdentifier = struct {
    /// The name of the CloudWatch alarm that you want Amazon Route 53 health
    /// checkers to use
    /// to determine whether this health check is healthy.
    ///
    /// Route 53 supports CloudWatch alarms with the following features:
    ///
    /// * Standard-resolution metrics. High-resolution metrics aren't supported. For
    /// more information, see [High-Resolution
    /// Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/publishingMetrics.html#high-resolution-metrics) in the *Amazon CloudWatch User
    /// Guide*.
    ///
    /// * Statistics: Average, Minimum, Maximum, Sum, and SampleCount. Extended
    /// statistics aren't supported.
    name: []const u8,

    /// For the CloudWatch alarm that you want Route 53 health checkers to use to
    /// determine
    /// whether this health check is healthy, the region that the alarm was created
    /// in.
    ///
    /// For the current list of CloudWatch regions, see [Amazon CloudWatch endpoints
    /// and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/cw_region.html) in the
    /// *Amazon Web Services General
    /// Reference*.
    region: CloudWatchRegion,
};
