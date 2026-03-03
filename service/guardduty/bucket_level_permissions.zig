const AccessControlList = @import("access_control_list.zig").AccessControlList;
const BlockPublicAccess = @import("block_public_access.zig").BlockPublicAccess;
const BucketPolicy = @import("bucket_policy.zig").BucketPolicy;

/// Contains information about the bucket level permissions for the S3 bucket.
pub const BucketLevelPermissions = struct {
    /// Contains information on how Access Control Policies are applied to the
    /// bucket.
    access_control_list: ?AccessControlList = null,

    /// Contains information on which account level S3 Block Public Access settings
    /// are applied to
    /// the S3 bucket.
    block_public_access: ?BlockPublicAccess = null,

    /// Contains information on the bucket policies for the S3 bucket.
    bucket_policy: ?BucketPolicy = null,

    pub const json_field_names = .{
        .access_control_list = "AccessControlList",
        .block_public_access = "BlockPublicAccess",
        .bucket_policy = "BucketPolicy",
    };
};
