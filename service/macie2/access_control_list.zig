/// Provides information about the permissions settings of the bucket-level
/// access control list (ACL) for an S3 bucket.
pub const AccessControlList = struct {
    /// Specifies whether the ACL grants the general public with read access
    /// permissions for the bucket.
    allows_public_read_access: ?bool = null,

    /// Specifies whether the ACL grants the general public with write access
    /// permissions for the bucket.
    allows_public_write_access: ?bool = null,

    pub const json_field_names = .{
        .allows_public_read_access = "allowsPublicReadAccess",
        .allows_public_write_access = "allowsPublicWriteAccess",
    };
};
