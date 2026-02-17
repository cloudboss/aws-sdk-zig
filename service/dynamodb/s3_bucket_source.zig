/// The S3 bucket that is being imported from.
pub const S3BucketSource = struct {
    /// The S3 bucket that is being imported from.
    s3_bucket: []const u8,

    /// The account number of the S3 bucket that is being imported from. If the
    /// bucket is
    /// owned by the requester this is optional.
    s3_bucket_owner: ?[]const u8,

    /// The key prefix shared by all S3 Objects that are being imported.
    s3_key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_bucket_owner = "S3BucketOwner",
        .s3_key_prefix = "S3KeyPrefix",
    };
};
