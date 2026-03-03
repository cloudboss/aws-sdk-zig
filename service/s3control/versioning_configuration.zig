const MFADelete = @import("mfa_delete.zig").MFADelete;
const BucketVersioningStatus = @import("bucket_versioning_status.zig").BucketVersioningStatus;

/// Describes the versioning state of an Amazon S3 on Outposts bucket. For more
/// information, see
/// [PutBucketVersioning](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketVersioning.html).
pub const VersioningConfiguration = struct {
    /// Specifies whether MFA delete is enabled or disabled in the bucket versioning
    /// configuration for the S3 on Outposts bucket.
    mfa_delete: ?MFADelete = null,

    /// Sets the versioning state of the S3 on Outposts bucket.
    status: ?BucketVersioningStatus = null,
};
