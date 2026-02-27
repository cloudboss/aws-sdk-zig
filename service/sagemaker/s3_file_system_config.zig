/// Configuration for the custom Amazon S3 file system.
pub const S3FileSystemConfig = struct {
    /// The file system path where the Amazon S3 storage location will be mounted
    /// within the Amazon SageMaker Studio environment.
    mount_path: ?[]const u8,

    /// The Amazon S3 URI of the S3 file system configuration.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .mount_path = "MountPath",
        .s3_uri = "S3Uri",
    };
};
