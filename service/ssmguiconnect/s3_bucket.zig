/// The S3 bucket where RDP connection recordings are stored.
pub const S3Bucket = struct {
    /// The name of the S3 bucket where RDP connection recordings are stored.
    bucket_name: []const u8,

    /// The Amazon Web Services account number that owns the S3 bucket.
    bucket_owner: []const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .bucket_owner = "BucketOwner",
    };
};
