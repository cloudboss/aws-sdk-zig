/// Required if the `RootDirectory` > `Path` specified does not exist.
/// Specifies the POSIX IDs and permissions to apply to the access point's
/// `RootDirectory` > `Path`.
/// If the access point root directory does not exist, EFS creates it with these
/// settings when a client connects to the access point.
/// When specifying `CreationInfo`, you must include values for all properties.
///
/// Amazon EFS creates a root directory only if you have provided the
/// CreationInfo: OwnUid, OwnGID, and permissions for the directory.
/// If you do not provide this information, Amazon EFS does not create the root
/// directory. If the root directory does not exist, attempts to mount
/// using the access point will fail.
///
/// If you do not provide `CreationInfo` and the specified `RootDirectory` does
/// not exist,
/// attempts to mount the file system using the access point will fail.
pub const CreationInfo = struct {
    /// Specifies the POSIX group ID to apply to the `RootDirectory`. Accepts values
    /// from 0 to 2^32 (4294967295).
    owner_gid: i64,

    /// Specifies the POSIX user ID to apply to the `RootDirectory`. Accepts values
    /// from 0 to 2^32 (4294967295).
    owner_uid: i64,

    /// Specifies the POSIX permissions to apply to the `RootDirectory`, in the
    /// format of an octal number representing the file's mode bits.
    permissions: []const u8,

    pub const json_field_names = .{
        .owner_gid = "OwnerGid",
        .owner_uid = "OwnerUid",
        .permissions = "Permissions",
    };
};
