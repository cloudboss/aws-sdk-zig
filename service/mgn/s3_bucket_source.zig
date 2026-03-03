/// S3 bucket source.
pub const S3BucketSource = struct {
    /// S3 bucket source s3 bucket.
    s_3_bucket: []const u8,

    /// S3 bucket source s3 bucket owner.
    s_3_bucket_owner: ?[]const u8 = null,

    /// S3 bucket source s3 key.
    s_3_key: []const u8,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
        .s_3_bucket_owner = "s3BucketOwner",
        .s_3_key = "s3Key",
    };
};
