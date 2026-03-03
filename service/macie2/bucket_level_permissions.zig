const AccessControlList = @import("access_control_list.zig").AccessControlList;
const BlockPublicAccess = @import("block_public_access.zig").BlockPublicAccess;
const BucketPolicy = @import("bucket_policy.zig").BucketPolicy;

/// Provides information about the bucket-level permissions settings for an S3
/// bucket.
pub const BucketLevelPermissions = struct {
    /// The permissions settings of the access control list (ACL) for the bucket.
    /// This value is null if an ACL hasn't been defined for the bucket.
    access_control_list: ?AccessControlList = null,

    /// The block public access settings for the bucket.
    block_public_access: ?BlockPublicAccess = null,

    /// The permissions settings of the bucket policy for the bucket. This value is
    /// null if a bucket policy hasn't been defined for the bucket.
    bucket_policy: ?BucketPolicy = null,

    pub const json_field_names = .{
        .access_control_list = "accessControlList",
        .block_public_access = "blockPublicAccess",
        .bucket_policy = "bucketPolicy",
    };
};
