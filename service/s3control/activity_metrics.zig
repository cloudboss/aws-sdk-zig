/// The container element for Amazon S3 Storage Lens activity metrics. Activity
/// metrics show details
/// about how your storage is requested, such as requests (for example, All
/// requests, Get
/// requests, Put requests), bytes uploaded or downloaded, and errors.
///
/// For more information about S3 Storage Lens, see [Assessing your storage
/// activity and usage with S3 Storage
/// Lens](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens.html) in the *Amazon S3 User Guide*. For a complete list of S3 Storage Lens metrics, see [S3 Storage Lens metrics glossary](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html) in the *Amazon S3 User Guide*.
pub const ActivityMetrics = struct {
    /// A container that indicates whether activity metrics are enabled.
    is_enabled: bool = false,
};
