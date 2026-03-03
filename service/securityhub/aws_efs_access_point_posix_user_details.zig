/// Provides details for all file system operations using this Amazon EFS access
/// point.
pub const AwsEfsAccessPointPosixUserDetails = struct {
    /// The POSIX group ID used for all file system operations using this access
    /// point.
    gid: ?[]const u8 = null,

    /// Secondary POSIX group IDs used for all file system operations using this
    /// access point.
    secondary_gids: ?[]const []const u8 = null,

    /// The POSIX user ID used for all file system operations using this access
    /// point.
    uid: ?[]const u8 = null,

    pub const json_field_names = .{
        .gid = "Gid",
        .secondary_gids = "SecondaryGids",
        .uid = "Uid",
    };
};
