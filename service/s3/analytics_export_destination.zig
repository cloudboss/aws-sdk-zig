const AnalyticsS3BucketDestination = @import("analytics_s_3_bucket_destination.zig").AnalyticsS3BucketDestination;

/// Where to publish the analytics results.
pub const AnalyticsExportDestination = struct {
    /// A destination signifying output to an S3 bucket.
    s_3_bucket_destination: AnalyticsS3BucketDestination,
};
