/// Details about the connection between a Lambda function and an [Amazon EFS
/// file
/// system](https://docs.aws.amazon.com/lambda/latest/dg/configuration-filesystem.html) or an [Amazon S3 Files file system](https://docs.aws.amazon.com/lambda/latest/dg/configuration-filesystem.html).
pub const FileSystemConfig = struct {
    /// The Amazon Resource Name (ARN) of the Amazon EFS or Amazon S3 Files access
    /// point that provides access to the file system.
    arn: []const u8,

    /// The path where the function can access the file system, starting with
    /// `/mnt/`.
    local_mount_path: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .local_mount_path = "LocalMountPath",
    };
};
