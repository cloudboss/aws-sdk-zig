/// The S3 bucket that is being imported from.
pub const S3BucketSource = struct {
    /// The S3 bucket that is being imported from.
    s_3_bucket: []const u8,

    /// The account number of the S3 bucket that is being imported from. If the
    /// bucket is
    /// owned by the requester this is optional.
    s_3_bucket_owner: ?[]const u8,

    /// The key prefix shared by all S3 Objects that are being imported.
    s_3_key_prefix: ?[]const u8,
};
