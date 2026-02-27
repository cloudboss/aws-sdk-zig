/// The container element for Amazon S3 Storage Lens detailed status code
/// metrics. Detailed status
/// code metrics generate metrics for HTTP status codes, such as `200 OK`, `403
/// Forbidden`, `503 Service Unavailable` and others.
///
/// For more information about S3 Storage Lens, see [Assessing your storage
/// activity and usage with S3 Storage
/// Lens](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens.html) in the *Amazon S3 User Guide*. For a complete list of S3 Storage Lens metrics, see [S3 Storage Lens metrics glossary](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html) in the *Amazon S3 User Guide*.
pub const DetailedStatusCodesMetrics = struct {
    /// A container that indicates whether detailed status code metrics are enabled.
    is_enabled: bool = false,
};
