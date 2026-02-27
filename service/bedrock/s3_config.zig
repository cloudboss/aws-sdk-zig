/// S3 configuration for storing log data.
pub const S3Config = struct {
    /// S3 bucket name.
    bucket_name: []const u8,

    /// S3 prefix.
    key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .key_prefix = "keyPrefix",
    };
};
