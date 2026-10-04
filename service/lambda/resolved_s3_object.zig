/// Details about the resolved Amazon S3 object that contains a function's
/// deployment package.
pub const ResolvedS3Object = struct {
    /// The Amazon S3 bucket that contains the deployment package.
    s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key of the deployment package.
    s3_key: ?[]const u8 = null,

    /// The version of the deployment package object.
    s3_object_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
        .s3_object_version = "S3ObjectVersion",
    };
};
