const EFSFileSystem = @import("efs_file_system.zig").EFSFileSystem;
const FSxLustreFileSystem = @import("f_sx_lustre_file_system.zig").FSxLustreFileSystem;
const S3FileSystem = @import("s3_file_system.zig").S3FileSystem;

/// A file system, created by you, that you assign to a user profile or space
/// for an Amazon SageMaker AI Domain. Permitted users can access this file
/// system in Amazon SageMaker AI Studio.
pub const CustomFileSystem = union(enum) {
    /// A custom file system in Amazon EFS.
    efs_file_system: ?EFSFileSystem,
    /// A custom file system in Amazon FSx for Lustre.
    f_sx_lustre_file_system: ?FSxLustreFileSystem,
    /// A custom file system in Amazon S3. This is only supported in Amazon
    /// SageMaker Unified Studio.
    s3_file_system: ?S3FileSystem,

    pub const json_field_names = .{
        .efs_file_system = "EFSFileSystem",
        .f_sx_lustre_file_system = "FSxLustreFileSystem",
        .s3_file_system = "S3FileSystem",
    };
};
