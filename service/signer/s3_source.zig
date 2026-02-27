/// Information about the Amazon S3 bucket where you saved your unsigned code.
pub const S3Source = struct {
    /// Name of the S3 bucket.
    bucket_name: []const u8,

    /// Key name of the bucket object that contains your unsigned code.
    key: []const u8,

    /// Version of your source image in your version enabled S3 bucket.
    version: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .key = "key",
        .version = "version",
    };
};
