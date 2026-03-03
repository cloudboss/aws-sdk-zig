const AccountLevelPermissions = @import("account_level_permissions.zig").AccountLevelPermissions;
const BucketLevelPermissions = @import("bucket_level_permissions.zig").BucketLevelPermissions;

/// Provides information about the account-level and bucket-level permissions
/// settings for an S3 bucket.
pub const BucketPermissionConfiguration = struct {
    /// The account-level permissions settings that apply to the bucket.
    account_level_permissions: ?AccountLevelPermissions = null,

    /// The bucket-level permissions settings for the bucket.
    bucket_level_permissions: ?BucketLevelPermissions = null,

    pub const json_field_names = .{
        .account_level_permissions = "accountLevelPermissions",
        .bucket_level_permissions = "bucketLevelPermissions",
    };
};
