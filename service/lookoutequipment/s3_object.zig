/// Contains information about an S3 bucket.
pub const S3Object = struct {
    /// The name of the specific S3 bucket.
    bucket: []const u8,

    /// The Amazon Web Services Key Management Service (KMS key) key being used to
    /// encrypt the S3 object.
    /// Without this key, data in the bucket is not accessible.
    key: []const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key = "Key",
    };
};
