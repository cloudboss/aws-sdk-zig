/// Contains information on the current access control policies for the bucket.
pub const AccessControlList = struct {
    /// A value that indicates whether public read access for the bucket is enabled
    /// through an
    /// Access Control List (ACL).
    allows_public_read_access: ?bool,

    /// A value that indicates whether public write access for the bucket is enabled
    /// through an
    /// Access Control List (ACL).
    allows_public_write_access: ?bool,

    pub const json_field_names = .{
        .allows_public_read_access = "AllowsPublicReadAccess",
        .allows_public_write_access = "AllowsPublicWriteAccess",
    };
};
