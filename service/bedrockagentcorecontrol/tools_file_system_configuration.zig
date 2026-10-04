const EfsConfiguration = @import("efs_configuration.zig").EfsConfiguration;
const S3FilesConfiguration = @import("s3_files_configuration.zig").S3FilesConfiguration;

/// Specifies a file system to mount into the session by providing exactly one
/// of the following:
///
/// * `s3FilesConfiguration` - Mounts an Amazon Simple Storage Service (Amazon
///   S3) Files access point.
/// * `efsConfiguration` - Mounts an Amazon Elastic File System (Amazon EFS)
///   access point.
pub const ToolsFileSystemConfiguration = union(enum) {
    /// The configuration for mounting your own Amazon Elastic File System (Amazon
    /// EFS) access point into the session.
    efs_configuration: ?EfsConfiguration,
    /// The configuration for mounting your own Amazon Simple Storage Service
    /// (Amazon S3) Files access point into the session.
    s_3_files_configuration: ?S3FilesConfiguration,

    pub const json_field_names = .{
        .efs_configuration = "efsConfiguration",
        .s_3_files_configuration = "s3FilesConfiguration",
    };
};
