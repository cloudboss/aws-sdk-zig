/// Specifies the POSIX identity with uid, gid, and secondary group IDs for user
/// enforcement.
pub const PosixUser = struct {
    /// The POSIX group ID.
    gid: i64,

    /// An array of secondary POSIX group IDs.
    secondary_gids: ?[]const i64 = null,

    /// The POSIX user ID.
    uid: i64,

    pub const json_field_names = .{
        .gid = "gid",
        .secondary_gids = "secondaryGids",
        .uid = "uid",
    };
};
