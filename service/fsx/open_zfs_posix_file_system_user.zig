/// The FSx for OpenZFS file system user that is used for authorizing all file
/// access requests that are made using the S3 access point.
pub const OpenZFSPosixFileSystemUser = struct {
    /// The GID of the file system user.
    gid: i64,

    /// The list of secondary GIDs for the file system user.
    secondary_gids: ?[]const i64,

    /// The UID of the file system user.
    uid: i64,

    pub const json_field_names = .{
        .gid = "Gid",
        .secondary_gids = "SecondaryGids",
        .uid = "Uid",
    };
};
