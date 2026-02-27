/// Provides information about the settings that Amazon EFS uses to create the
/// root directory
/// when a client connects to an access point.
pub const AwsEfsAccessPointRootDirectoryCreationInfoDetails = struct {
    /// Specifies the POSIX group ID to apply to the root directory.
    owner_gid: ?[]const u8,

    /// Specifies the POSIX user ID to apply to the root directory.
    owner_uid: ?[]const u8,

    /// Specifies the POSIX permissions to apply to the root directory, in the
    /// format of an octal number
    /// representing the file's mode bits.
    permissions: ?[]const u8,

    pub const json_field_names = .{
        .owner_gid = "OwnerGid",
        .owner_uid = "OwnerUid",
        .permissions = "Permissions",
    };
};
