/// Details about the POSIX identity that is used for file system operations.
pub const CustomPosixUserConfig = struct {
    /// The POSIX group ID.
    gid: i64,

    /// The POSIX user ID.
    uid: i64,

    pub const json_field_names = .{
        .gid = "Gid",
        .uid = "Uid",
    };
};
