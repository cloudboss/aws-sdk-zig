const AwsEfsAccessPointPosixUserDetails = @import("aws_efs_access_point_posix_user_details.zig").AwsEfsAccessPointPosixUserDetails;
const AwsEfsAccessPointRootDirectoryDetails = @import("aws_efs_access_point_root_directory_details.zig").AwsEfsAccessPointRootDirectoryDetails;

/// Provides information about an Amazon EFS access point.
pub const AwsEfsAccessPointDetails = struct {
    /// The ID of the Amazon EFS access point.
    access_point_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon EFS access point.
    arn: ?[]const u8 = null,

    /// The opaque string specified in the request to ensure idempotent creation.
    client_token: ?[]const u8 = null,

    /// The ID of the Amazon EFS file system that the access point applies to.
    file_system_id: ?[]const u8 = null,

    /// The full POSIX identity, including the user ID, group ID, and secondary
    /// group IDs on the access point,
    /// that is used for all file operations by NFS clients using the access point.
    posix_user: ?AwsEfsAccessPointPosixUserDetails = null,

    /// The directory on the Amazon EFS file system that the access point exposes as
    /// the root
    /// directory to NFS clients using the access point.
    root_directory: ?AwsEfsAccessPointRootDirectoryDetails = null,

    pub const json_field_names = .{
        .access_point_id = "AccessPointId",
        .arn = "Arn",
        .client_token = "ClientToken",
        .file_system_id = "FileSystemId",
        .posix_user = "PosixUser",
        .root_directory = "RootDirectory",
    };
};
