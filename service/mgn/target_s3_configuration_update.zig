/// Updated S3 configuration for storing target network artifacts.
pub const TargetS3ConfigurationUpdate = struct {
    /// The updated name of the S3 bucket.
    s_3_bucket: ?[]const u8 = null,

    /// The updated AWS account ID of the S3 bucket owner.
    s_3_bucket_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
        .s_3_bucket_owner = "s3BucketOwner",
    };
};
