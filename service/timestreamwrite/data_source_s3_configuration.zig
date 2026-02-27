pub const DataSourceS3Configuration = struct {
    /// The bucket name of the customer S3 bucket.
    bucket_name: []const u8,

    object_key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_key_prefix = "ObjectKeyPrefix",
    };
};
