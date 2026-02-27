const S3BucketDestination = @import("s3_bucket_destination.zig").S3BucketDestination;
const StorageLensTableDestination = @import("storage_lens_table_destination.zig").StorageLensTableDestination;

/// A container for your S3 Storage Lens expanded prefix metrics report
/// configuration. Unlike the
/// default Storage Lens metrics report, the enhanced prefix metrics report
/// includes all
/// S3 Storage Lens storage and activity data related to the full list of
/// prefixes in your Storage
/// Lens configuration.
pub const StorageLensExpandedPrefixesDataExport = struct {
    s3_bucket_destination: ?S3BucketDestination,

    /// A container for the bucket where the S3 Storage Lens metric export files are
    /// located. At least one export destination must be specified.
    storage_lens_table_destination: ?StorageLensTableDestination,
};
