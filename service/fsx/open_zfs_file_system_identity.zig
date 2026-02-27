const OpenZFSPosixFileSystemUser = @import("open_zfs_posix_file_system_user.zig").OpenZFSPosixFileSystemUser;
const OpenZFSFileSystemUserType = @import("open_zfs_file_system_user_type.zig").OpenZFSFileSystemUserType;

/// Specifies the file system user identity that will be used for authorizing
/// all file access requests that are made using the S3 access point.
pub const OpenZFSFileSystemIdentity = struct {
    /// Specifies the UID and GIDs of the file system POSIX user.
    posix_user: ?OpenZFSPosixFileSystemUser,

    /// Specifies the FSx for OpenZFS user identity type, accepts only `POSIX`.
    type: OpenZFSFileSystemUserType,

    pub const json_field_names = .{
        .posix_user = "PosixUser",
        .type = "Type",
    };
};
