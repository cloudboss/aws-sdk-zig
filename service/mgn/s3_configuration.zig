/// Configuration for an S3 location.
pub const S3Configuration = struct {
    /// The name of the S3 bucket.
    s_3_bucket: ?[]const u8 = null,

    /// The AWS account ID of the S3 bucket owner.
    s_3_bucket_owner: ?[]const u8 = null,

    /// The S3 key (path) for the object.
    s_3_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
        .s_3_bucket_owner = "s3BucketOwner",
        .s_3_key = "s3Key",
    };
};
