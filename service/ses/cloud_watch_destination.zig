const CloudWatchDimensionConfiguration = @import("cloud_watch_dimension_configuration.zig").CloudWatchDimensionConfiguration;

/// Contains information associated with an Amazon CloudWatch event destination
/// to which email
/// sending events are published.
///
/// Event destinations, such as Amazon CloudWatch, are associated with
/// configuration sets, which
/// enable you to publish email sending events. For information about using
/// configuration
/// sets, see the [Amazon SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
pub const CloudWatchDestination = struct {
    /// A list of dimensions upon which to categorize your emails when you publish
    /// email
    /// sending events to Amazon CloudWatch.
    dimension_configurations: []const CloudWatchDimensionConfiguration,
};
