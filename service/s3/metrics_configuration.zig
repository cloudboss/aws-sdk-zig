const MetricsFilter = @import("metrics_filter.zig").MetricsFilter;

/// Specifies a metrics configuration for the CloudWatch request metrics
/// (specified by the metrics
/// configuration ID) from an Amazon S3 bucket. If you're updating an existing
/// metrics configuration, note that
/// this is a full replacement of the existing metrics configuration. If you
/// don't include the elements you
/// want to keep, they are erased. For more information, see
/// [PutBucketMetricsConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTMetricConfiguration.html).
pub const MetricsConfiguration = struct {
    /// Specifies a metrics configuration filter. The metrics configuration will
    /// only include objects that
    /// meet the filter's criteria. A filter must be a prefix, an object tag, an
    /// access point ARN, or a
    /// conjunction (MetricsAndOperator).
    filter: ?MetricsFilter,

    /// The ID used to identify the metrics configuration. The ID has a 64 character
    /// limit and can only
    /// contain letters, numbers, periods, dashes, and underscores.
    id: []const u8,
};
