/// Amazon S3 logging configuration.
pub const S3Logs = struct {
    /// The S3 bucket in which to store the logs.
    s_3_bucket_name: ?[]const u8,

    /// The Amazon S3 path to the bucket where the logs are stored.
    s_3_key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .s_3_bucket_name = "s3BucketName",
        .s_3_key_prefix = "s3KeyPrefix",
    };
};
