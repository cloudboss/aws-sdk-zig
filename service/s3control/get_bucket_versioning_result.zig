const MFADeleteStatus = @import("mfa_delete_status.zig").MFADeleteStatus;
const BucketVersioningStatus = @import("bucket_versioning_status.zig").BucketVersioningStatus;

pub const GetBucketVersioningResult = struct {
    /// Specifies whether MFA delete is enabled in the bucket versioning
    /// configuration. This
    /// element is returned only if the bucket has been configured with MFA delete.
    /// If MFA delete
    /// has never been configured for the bucket, this element is not returned.
    mfa_delete: ?MFADeleteStatus = null,

    /// The versioning state of the S3 on Outposts bucket.
    status: ?BucketVersioningStatus = null,
};
