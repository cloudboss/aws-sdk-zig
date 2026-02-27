/// The full POSIX identity, including user ID (`Uid`), group ID (`Gid`), and
/// any secondary groups IDs (`SecondaryGids`), that controls your users' access
/// to your Amazon EFS file systems. The POSIX permissions that are set on files
/// and directories in your file system determine the level of access your users
/// get when transferring files into and out of your Amazon EFS file systems.
pub const PosixProfile = struct {
    /// The POSIX group ID used for all EFS operations by this user.
    gid: i64,

    /// The secondary POSIX group IDs used for all EFS operations by this user.
    secondary_gids: ?[]const i64,

    /// The POSIX user ID used for all EFS operations by this user.
    uid: i64,

    pub const json_field_names = .{
        .gid = "Gid",
        .secondary_gids = "SecondaryGids",
        .uid = "Uid",
    };
};
