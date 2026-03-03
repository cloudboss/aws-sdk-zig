/// The location in Amazon S3 where build or script files are stored for access
/// by
/// Amazon GameLift Servers.
pub const S3Location = struct {
    /// An Amazon S3 bucket identifier. Thename of the S3 bucket.
    ///
    /// Amazon GameLift Servers doesn't support uploading from Amazon S3 buckets
    /// with names that contain a dot
    /// (.).
    bucket: ?[]const u8 = null,

    /// The name of the zip file that contains the build files or script files.
    key: ?[]const u8 = null,

    /// The version of the file, if object versioning is turned on for the bucket.
    /// Amazon GameLift Servers uses
    /// this information when retrieving files from an S3 bucket that you own. Use
    /// this
    /// parameter to specify a specific version of the file. If not set, the latest
    /// version of
    /// the file is retrieved.
    object_version: ?[]const u8 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// for an IAM role that
    /// allows Amazon GameLift Servers to access the S3 bucket.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key = "Key",
        .object_version = "ObjectVersion",
        .role_arn = "RoleArn",
    };
};
