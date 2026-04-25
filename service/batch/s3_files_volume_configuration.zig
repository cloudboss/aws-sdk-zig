/// This is used when you're using an S3Files file system for job storage.
pub const S3FilesVolumeConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the S3Files access point to use.
    access_point_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the S3Files file system to use.
    file_system_arn: []const u8,

    /// The directory within the S3Files file system to mount as the root directory.
    root_directory: ?[]const u8 = null,

    /// The port to use when sending encrypted data between the Amazon ECS host and
    /// the S3Files file system
    /// server.
    transit_encryption_port: ?i32 = null,

    pub const json_field_names = .{
        .access_point_arn = "accessPointArn",
        .file_system_arn = "fileSystemArn",
        .root_directory = "rootDirectory",
        .transit_encryption_port = "transitEncryptionPort",
    };
};
