const AccountLevelPermissions = @import("account_level_permissions.zig").AccountLevelPermissions;
const BucketLevelPermissions = @import("bucket_level_permissions.zig").BucketLevelPermissions;

/// Contains information about how permissions are configured for the S3 bucket.
pub const PermissionConfiguration = struct {
    /// Contains information about the account level permissions on the S3 bucket.
    account_level_permissions: ?AccountLevelPermissions = null,

    /// Contains information about the bucket level permissions for the S3 bucket.
    bucket_level_permissions: ?BucketLevelPermissions = null,

    pub const json_field_names = .{
        .account_level_permissions = "AccountLevelPermissions",
        .bucket_level_permissions = "BucketLevelPermissions",
    };
};
