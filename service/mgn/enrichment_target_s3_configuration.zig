/// S3 configuration for storing the enriched import file.
pub const EnrichmentTargetS3Configuration = struct {
    /// The name of the S3 bucket where the enriched import file will be stored.
    s_3_bucket: []const u8,

    /// The AWS account ID of the target S3 bucket owner.
    s_3_bucket_owner: []const u8,

    /// The S3 key (path) where the enriched import file will be stored.
    s_3_key: []const u8,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
        .s_3_bucket_owner = "s3BucketOwner",
        .s_3_key = "s3Key",
    };
};
