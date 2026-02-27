const AclGrantee = @import("acl_grantee.zig").AclGrantee;
const AclPermission = @import("acl_permission.zig").AclPermission;

/// A proposed access control list grant configuration for an Amazon S3 bucket.
/// For more information, see [How to Specify an
/// ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#setting-acls).
pub const S3BucketAclGrantConfiguration = struct {
    /// The grantee to whom you’re assigning access rights.
    grantee: AclGrantee,

    /// The permissions being granted.
    permission: AclPermission,

    pub const json_field_names = .{
        .grantee = "grantee",
        .permission = "permission",
    };
};
