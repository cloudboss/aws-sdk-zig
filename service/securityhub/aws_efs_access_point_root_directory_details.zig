const AwsEfsAccessPointRootDirectoryCreationInfoDetails = @import("aws_efs_access_point_root_directory_creation_info_details.zig").AwsEfsAccessPointRootDirectoryCreationInfoDetails;

/// Provides information about the directory on the Amazon EFS file system that
/// the access point exposes
/// as the root directory to NFS clients using the access point.
pub const AwsEfsAccessPointRootDirectoryDetails = struct {
    /// Specifies the POSIX IDs and permissions to apply to the access point's root
    /// directory.
    creation_info: ?AwsEfsAccessPointRootDirectoryCreationInfoDetails = null,

    /// Specifies the path on the Amazon EFS file system to expose as the root
    /// directory to NFS clients
    /// using the access point to access the EFS file system. A path can have up to
    /// four subdirectories. If the specified
    /// path does not exist, you are required to provide `CreationInfo`.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_info = "CreationInfo",
        .path = "Path",
    };
};
