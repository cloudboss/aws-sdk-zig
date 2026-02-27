/// Contains information about an Amazon S3 bucket.
pub const S3Bucket = struct {
    /// The name of the Amazon S3 bucket.
    bucket_name: []const u8,

    /// The object key to use.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .prefix = "prefix",
    };
};
