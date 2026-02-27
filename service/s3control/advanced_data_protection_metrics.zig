/// The container element for Amazon S3 Storage Lens advanced data-protection
/// metrics. Advanced
/// data-protection metrics provide insights that you can use to perform audits
/// and protect
/// your data, for example replication rule counts within and across Regions.
///
/// For more information about S3 Storage Lens, see [Assessing your storage
/// activity and usage with S3 Storage
/// Lens](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens.html) in the *Amazon S3 User Guide*. For a complete list of S3 Storage Lens metrics, see [S3 Storage Lens metrics glossary](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html) in the *Amazon S3 User Guide*.
pub const AdvancedDataProtectionMetrics = struct {
    /// A container that indicates whether advanced data-protection metrics are
    /// enabled.
    is_enabled: bool = false,
};
