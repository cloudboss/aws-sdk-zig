const S3FilesConfig = @import("s3_files_config.zig").S3FilesConfig;

/// Details about the connection between a Lambda function and an [Amazon EFS
/// file
/// system](https://docs.aws.amazon.com/lambda/latest/dg/configuration-filesystem.html) or an [Amazon S3 file system](https://docs.aws.amazon.com/lambda/latest/dg/configuration-filesystem.html).
pub const FileSystemConfig = struct {
    /// The Amazon Resource Name (ARN) of the Amazon EFS or Amazon S3 Files access
    /// point that provides access to the file system.
    arn: []const u8,

    /// The path where the function can access the file system, starting with
    /// `/mnt/`.
    local_mount_path: []const u8,

    /// The configuration for how your function accesses data on an Amazon S3 file
    /// system. Valid only when the file system access point ARN is an Amazon S3
    /// Files access point. If you specify a different access point type (for
    /// example, Amazon Elastic File System), the operation returns an
    /// `InvalidParameterException`.
    s3_files_config: ?S3FilesConfig = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .local_mount_path = "LocalMountPath",
        .s3_files_config = "S3FilesConfig",
    };
};
