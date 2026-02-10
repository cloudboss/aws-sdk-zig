const Grantee = @import("grantee.zig").Grantee;
const BucketLogsPermission = @import("bucket_logs_permission.zig").BucketLogsPermission;

/// Container for granting information.
///
/// Buckets that use the bucket owner enforced setting for Object Ownership
/// don't support target grants.
/// For more information, see [Permissions server access log
/// delivery](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html#grant-log-delivery-permissions-general) in the *Amazon S3 User Guide*.
pub const TargetGrant = struct {
    /// Container for the person being granted permissions.
    grantee: ?Grantee,

    /// Logging permissions assigned to the grantee for the bucket.
    permission: ?BucketLogsPermission,
};
