/// Amazon S3 logging configuration.
pub const S3Logs = struct {
    /// The name of an existing Amazon S3 bucket where Image Builder saves build
    /// logs. The bucket
    /// isn't validated when you create or update the configuration, and Image
    /// Builder
    /// doesn't create it. The instance profile associated with this
    /// infrastructure configuration must have permission to write to the
    /// bucket.
    s_3_bucket_name: ?[]const u8 = null,

    /// The Amazon S3 key prefix under which Image Builder writes build and test
    /// logs in the
    /// bucket.
    s_3_key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_bucket_name = "s3BucketName",
        .s_3_key_prefix = "s3KeyPrefix",
    };
};
