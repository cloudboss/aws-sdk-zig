const MetricsName = @import("metrics_name.zig").MetricsName;

/// Represents enhanced metrics types.
pub const EnhancedMetrics = struct {
    /// List of shard-level metrics.
    ///
    /// The following are the valid shard-level metrics. The value "`ALL`" enhances
    /// every metric.
    ///
    /// * `IncomingBytes`
    ///
    /// * `IncomingRecords`
    ///
    /// * `OutgoingBytes`
    ///
    /// * `OutgoingRecords`
    ///
    /// * `WriteProvisionedThroughputExceeded`
    ///
    /// * `ReadProvisionedThroughputExceeded`
    ///
    /// * `IteratorAgeMilliseconds`
    ///
    /// * `ALL`
    ///
    /// For more information, see [Monitoring the Amazon
    /// Kinesis Data Streams Service with Amazon
    /// CloudWatch](https://docs.aws.amazon.com/kinesis/latest/dev/monitoring-with-cloudwatch.html) in the *Amazon
    /// Kinesis Data Streams Developer Guide*.
    shard_level_metrics: ?[]const MetricsName = null,

    pub const json_field_names = .{
        .shard_level_metrics = "ShardLevelMetrics",
    };
};
