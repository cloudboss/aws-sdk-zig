/// The description of the location of an object in Amazon S3.
pub const S3LocationDescription = struct {
    /// The Amazon Resource Name (ARN) of an S3 bucket.
    bucket_arn: ?[]const u8,

    /// The file key for an object in an S3 bucket.
    file_key: ?[]const u8,

    /// The version of an object in an S3 bucket.
    object_version: ?[]const u8,

    pub const json_field_names = .{
        .bucket_arn = "bucketArn",
        .file_key = "fileKey",
        .object_version = "objectVersion",
    };
};
