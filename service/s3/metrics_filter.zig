const MetricsAndOperator = @import("metrics_and_operator.zig").MetricsAndOperator;
const Tag = @import("tag.zig").Tag;

/// Specifies a metrics configuration filter. The metrics configuration only
/// includes objects that meet
/// the filter's criteria. A filter must be a prefix, an object tag, an access
/// point ARN, or a conjunction
/// (MetricsAndOperator). For more information, see
/// [PutBucketMetricsConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketMetricsConfiguration.html).
pub const MetricsFilter = union(enum) {
    /// The access point ARN used when evaluating a metrics filter.
    access_point_arn: ?[]const u8,
    /// A conjunction (logical AND) of predicates, which is used in evaluating a
    /// metrics filter. The
    /// operator must have at least two predicates, and an object must match all of
    /// the predicates in order for
    /// the filter to apply.
    @"and": ?MetricsAndOperator,
    /// The prefix used when evaluating a metrics filter.
    prefix: ?[]const u8,
    /// The tag used when evaluating a metrics filter.
    ///
    /// `Tag` filters are not supported for directory buckets.
    tag: ?Tag,
};
