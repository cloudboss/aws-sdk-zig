const EffectivePermission = @import("effective_permission.zig").EffectivePermission;
const BucketPermissionConfiguration = @import("bucket_permission_configuration.zig").BucketPermissionConfiguration;

/// Provides information about the permissions settings that determine whether
/// an S3 bucket is publicly accessible.
pub const BucketPublicAccess = struct {
    /// Specifies whether the bucket is publicly accessible due to the combination
    /// of permissions settings that apply to the bucket. Possible values are:
    ///
    /// * NOT_PUBLIC - The bucket isn't publicly accessible.
    /// * PUBLIC - The bucket is publicly accessible.
    /// * UNKNOWN - Amazon Macie can't determine whether the bucket is publicly
    ///   accessible.
    effective_permission: ?EffectivePermission = null,

    /// The account-level and bucket-level permissions settings for the bucket.
    permission_configuration: ?BucketPermissionConfiguration = null,

    pub const json_field_names = .{
        .effective_permission = "effectivePermission",
        .permission_configuration = "permissionConfiguration",
    };
};
