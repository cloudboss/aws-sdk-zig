/// S3 configuration for storing target network artifacts.
pub const TargetS3Configuration = struct {
    /// The name of the S3 bucket for target artifacts.
    s_3_bucket: []const u8,

    /// The AWS account ID of the S3 bucket owner.
    s_3_bucket_owner: []const u8,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
        .s_3_bucket_owner = "s3BucketOwner",
    };
};
