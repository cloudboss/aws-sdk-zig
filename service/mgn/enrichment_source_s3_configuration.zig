/// S3 configuration for the source import file to be enriched.
pub const EnrichmentSourceS3Configuration = struct {
    /// The name of the S3 bucket containing the source import file.
    s_3_bucket: []const u8,

    /// The AWS account ID of the S3 bucket owner.
    s_3_bucket_owner: []const u8,

    /// The S3 key (path) for the source import file.
    s_3_key: []const u8,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
        .s_3_bucket_owner = "s3BucketOwner",
        .s_3_key = "s3Key",
    };
};
