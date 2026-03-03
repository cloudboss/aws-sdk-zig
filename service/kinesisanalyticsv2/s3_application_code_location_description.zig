/// Describes the location of an application's code stored in an S3 bucket.
pub const S3ApplicationCodeLocationDescription = struct {
    /// The Amazon Resource Name (ARN) for the S3 bucket containing the application
    /// code.
    bucket_arn: []const u8,

    /// The file key for the object containing the application code.
    file_key: []const u8,

    /// The version of the object containing the application code.
    object_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .file_key = "FileKey",
        .object_version = "ObjectVersion",
    };
};
