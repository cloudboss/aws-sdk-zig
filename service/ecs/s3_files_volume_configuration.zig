/// This parameter is specified when you're using an Amazon S3 Files file system
/// for task storage. For more information, see [Amazon S3 Files
/// volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/s3files-volumes.html) in the *Amazon Elastic Container Service Developer Guide*.
///
/// Your task definition must include a Task IAM Role. See [ IAM role for
/// attaching your file system to AWS compute
/// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-files-prereq-policies.html#s3-files-prereq-iam-compute-role) for required permissions.
pub const S3FilesVolumeConfiguration = struct {
    /// The full ARN of the S3 Files access point to use. If an access point is
    /// specified, the root directory value specified in the
    /// `S3FilesVolumeConfiguration` must either be omitted or set to `/` which will
    /// enforce the path set on the S3 Files access point. For more information, see
    /// [Creating S3 Files access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-files-access-points-creating.html).
    access_point_arn: ?[]const u8 = null,

    /// The full ARN of the S3 Files file system to mount.
    file_system_arn: []const u8,

    /// The directory within the Amazon S3 Files file system to mount as the root
    /// directory. If this parameter is omitted, the root of the Amazon S3 Files
    /// file system will be used. Specifying `/` will have the same effect as
    /// omitting this parameter.
    ///
    /// If a S3 Files access point is specified in the `accessPointArn`, the root
    /// directory parameter must either be omitted or set to `/` which will enforce
    /// the path set on the S3 Files access point.
    root_directory: ?[]const u8 = null,

    /// The port to use for sending encrypted data between the ECS host and the S3
    /// Files file system. If you do not specify a transit encryption port, it will
    /// use the port selection strategy that the Amazon S3 Files mount helper uses.
    /// For more information, see [S3 Files mount
    /// helper](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-files-mounting.html).
    transit_encryption_port: ?i32 = null,

    pub const json_field_names = .{
        .access_point_arn = "accessPointArn",
        .file_system_arn = "fileSystemArn",
        .root_directory = "rootDirectory",
        .transit_encryption_port = "transitEncryptionPort",
    };
};
