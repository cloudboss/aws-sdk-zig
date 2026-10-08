/// Specifies the permissions to set on newly created directories within the
/// file system.
pub const CreationPermissions = struct {
    /// The POSIX group ID to assign to newly created directories.
    owner_gid: i64,

    /// The POSIX user ID to assign to newly created directories.
    owner_uid: i64,

    /// The octal permissions to assign to newly created directories.
    permissions: []const u8,

    pub const json_field_names = .{
        .owner_gid = "ownerGid",
        .owner_uid = "ownerUid",
        .permissions = "permissions",
    };
};
