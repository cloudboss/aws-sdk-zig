const CloudWatchMetrics = @import("cloud_watch_metrics.zig").CloudWatchMetrics;
const S3BucketDestination = @import("s3_bucket_destination.zig").S3BucketDestination;
const StorageLensTableDestination = @import("storage_lens_table_destination.zig").StorageLensTableDestination;

/// A container to specify the properties of your S3 Storage Lens metrics
/// export, including the
/// destination, schema, and format.
pub const StorageLensDataExport = struct {
    /// A container for enabling Amazon CloudWatch publishing for S3 Storage Lens
    /// metrics.
    cloud_watch_metrics: ?CloudWatchMetrics,

    /// A container for the bucket where the S3 Storage Lens metrics export will be
    /// located.
    ///
    /// This bucket must be located in the same Region as the storage lens
    /// configuration.
    s3_bucket_destination: ?S3BucketDestination,

    /// A container for configuring S3 Storage Lens data exports to read-only S3
    /// table buckets.
    storage_lens_table_destination: ?StorageLensTableDestination,
};
