/// A container for enabling Amazon CloudWatch publishing for S3 Storage Lens
/// metrics.
///
/// For more information about publishing S3 Storage Lens metrics to CloudWatch,
/// see [Monitor
/// S3 Storage Lens metrics in
/// CloudWatch](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_view_metrics_cloudwatch.html) in the *Amazon S3 User Guide*.
pub const CloudWatchMetrics = struct {
    /// A container that indicates whether CloudWatch publishing for S3 Storage Lens
    /// metrics is enabled. A
    /// value of `true` indicates that CloudWatch publishing for S3 Storage Lens
    /// metrics is
    /// enabled.
    is_enabled: bool = false,
};
