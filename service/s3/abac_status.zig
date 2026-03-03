const BucketAbacStatus = @import("bucket_abac_status.zig").BucketAbacStatus;

/// The ABAC status of the general purpose bucket. When ABAC is enabled for the
/// general purpose bucket, you can use tags to manage access to the general
/// purpose buckets as well as for cost tracking purposes. When ABAC is disabled
/// for the general purpose buckets, you can only use tags for cost tracking
/// purposes. For more information, see [Using tags with S3 general purpose
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/buckets-tagging.html).
pub const AbacStatus = struct {
    /// The ABAC status of the general purpose bucket.
    status: ?BucketAbacStatus = null,
};
