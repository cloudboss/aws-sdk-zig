const BucketAccelerateStatus = @import("bucket_accelerate_status.zig").BucketAccelerateStatus;

/// Configures the transfer acceleration state for an Amazon S3 bucket. For more
/// information, see [Amazon S3 Transfer
/// Acceleration](https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html) in the *Amazon S3 User Guide*.
pub const AccelerateConfiguration = struct {
    /// Specifies the transfer acceleration status of the bucket.
    status: ?BucketAccelerateStatus = null,
};
