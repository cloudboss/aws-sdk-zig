/// Amazon S3 object representing the updated message content, in MIME format.
///
/// The region for the S3 bucket containing the S3 object must match the region
/// used for WorkMail operations. Also, for WorkMail to process
/// an S3 object, it must have permission to access that object. For more
/// information, see
/// [
/// Updating message content with AWS
/// Lambda](https://docs.aws.amazon.com/workmail/latest/adminguide/update-with-lambda.html).
pub const S3Reference = struct {
    /// The S3 bucket name.
    bucket: []const u8,

    /// The S3 key object name.
    key: []const u8,

    /// If you enable versioning for the bucket, you can specify the object version.
    object_version: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
        .object_version = "objectVersion",
    };
};
