/// The full POSIX identity, including the user ID, group ID, and any secondary
/// group IDs, on the access point that is used for all file system operations
/// performed by
/// NFS clients using the access point.
pub const PosixUser = struct {
    /// The POSIX group ID used for all file system operations using this access
    /// point.
    gid: i64,

    /// Secondary POSIX group IDs used for all file system operations using this
    /// access point.
    secondary_gids: ?[]const i64,

    /// The POSIX user ID used for all file system operations using this access
    /// point.
    uid: i64,

    pub const json_field_names = .{
        .gid = "Gid",
        .secondary_gids = "SecondaryGids",
        .uid = "Uid",
    };
};
