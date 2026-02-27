const EFSFileSystemConfig = @import("efs_file_system_config.zig").EFSFileSystemConfig;
const FSxLustreFileSystemConfig = @import("f_sx_lustre_file_system_config.zig").FSxLustreFileSystemConfig;
const S3FileSystemConfig = @import("s3_file_system_config.zig").S3FileSystemConfig;

/// The settings for assigning a custom file system to a user profile or space
/// for an Amazon SageMaker AI Domain. Permitted users can access this file
/// system in Amazon SageMaker AI Studio.
pub const CustomFileSystemConfig = union(enum) {
    /// The settings for a custom Amazon EFS file system.
    efs_file_system_config: ?EFSFileSystemConfig,
    /// The settings for a custom Amazon FSx for Lustre file system.
    f_sx_lustre_file_system_config: ?FSxLustreFileSystemConfig,
    /// Configuration settings for a custom Amazon S3 file system.
    s3_file_system_config: ?S3FileSystemConfig,

    pub const json_field_names = .{
        .efs_file_system_config = "EFSFileSystemConfig",
        .f_sx_lustre_file_system_config = "FSxLustreFileSystemConfig",
        .s3_file_system_config = "S3FileSystemConfig",
    };
};
