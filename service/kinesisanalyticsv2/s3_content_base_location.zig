/// The S3 bucket that holds the application information.
pub const S3ContentBaseLocation = struct {
    /// The base path for the S3 bucket.
    base_path: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the S3 bucket.
    bucket_arn: []const u8,

    pub const json_field_names = .{
        .base_path = "BasePath",
        .bucket_arn = "BucketARN",
    };
};
