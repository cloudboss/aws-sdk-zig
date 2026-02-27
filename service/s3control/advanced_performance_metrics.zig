/// The container element for S3 Storage Lens advanced performance metrics.
/// Advanced
/// performance metrics provide insights into application performance, such as
/// request
/// efficiency and access patterns. These metrics help you optimize your
/// S3 storage for both cost and performance by providing detailed analytics on
/// how your
/// applications interact with S3 resources.
///
/// For more information about S3 Storage Lens, see [Assessing your storage
/// activity and usage with S3 Storage
/// Lens](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens.html) in the *Amazon S3 User Guide*. For a complete list of S3 Storage Lens metrics, see [S3 Storage Lens metrics glossary](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html) in the *Amazon S3 User Guide*.
pub const AdvancedPerformanceMetrics = struct {
    /// A container that indicates whether S3 Storage Lens advanced performance
    /// metrics are enabled.
    is_enabled: bool = false,
};
