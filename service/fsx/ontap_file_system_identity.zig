const OntapFileSystemUserType = @import("ontap_file_system_user_type.zig").OntapFileSystemUserType;
const OntapUnixFileSystemUser = @import("ontap_unix_file_system_user.zig").OntapUnixFileSystemUser;
const OntapWindowsFileSystemUser = @import("ontap_windows_file_system_user.zig").OntapWindowsFileSystemUser;

/// Specifies the file system user identity that will be used for authorizing
/// all file access requests that are made using the S3 access point. The
/// identity can be either a UNIX user or a Windows user.
pub const OntapFileSystemIdentity = struct {
    /// Specifies the FSx for ONTAP user identity type. Valid values are `UNIX` and
    /// `WINDOWS`.
    @"type": OntapFileSystemUserType,

    /// Specifies the UNIX user identity for file system operations.
    unix_user: ?OntapUnixFileSystemUser,

    /// Specifies the Windows user identity for file system operations.
    windows_user: ?OntapWindowsFileSystemUser,

    pub const json_field_names = .{
        .@"type" = "Type",
        .unix_user = "UnixUser",
        .windows_user = "WindowsUser",
    };
};
