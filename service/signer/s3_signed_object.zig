/// The Amazon S3 bucket name and key where Signer saved your signed code image.
pub const S3SignedObject = struct {
    /// Name of the S3 bucket.
    bucket_name: ?[]const u8,

    /// Key name that uniquely identifies a signed code image in your bucket.
    key: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .key = "key",
    };
};
