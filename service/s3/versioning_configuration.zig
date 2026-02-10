const MFADelete = @import("mfa_delete.zig").MFADelete;
const BucketVersioningStatus = @import("bucket_versioning_status.zig").BucketVersioningStatus;

/// Describes the versioning state of an Amazon S3 bucket. For more information,
/// see [PUT Bucket
/// versioning](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTVersioningStatus.html) in the *Amazon S3 API Reference*.
pub const VersioningConfiguration = struct {
    /// Specifies whether MFA delete is enabled in the bucket versioning
    /// configuration. This element is only
    /// returned if the bucket has been configured with MFA delete. If the bucket
    /// has never been so configured,
    /// this element is not returned.
    mfa_delete: ?MFADelete,

    /// The versioning state of the bucket.
    status: ?BucketVersioningStatus,
};
