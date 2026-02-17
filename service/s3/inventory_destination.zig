const InventoryS3BucketDestination = @import("inventory_s3_bucket_destination.zig").InventoryS3BucketDestination;

/// Specifies the S3 Inventory configuration for an Amazon S3 bucket.
pub const InventoryDestination = struct {
    /// Contains the bucket name, file format, bucket owner (optional), and prefix
    /// (optional) where
    /// inventory results are published.
    s3_bucket_destination: InventoryS3BucketDestination,
};
