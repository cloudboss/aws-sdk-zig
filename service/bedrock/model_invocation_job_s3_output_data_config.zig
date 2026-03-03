/// Contains the configuration of the S3 location of the output data.
pub const ModelInvocationJobS3OutputDataConfig = struct {
    /// The ID of the Amazon Web Services account that owns the S3 bucket containing
    /// the output data.
    s_3_bucket_owner: ?[]const u8 = null,

    /// The unique identifier of the key that encrypts the S3 location of the output
    /// data.
    s_3_encryption_key_id: ?[]const u8 = null,

    /// The S3 location of the output data.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_bucket_owner = "s3BucketOwner",
        .s_3_encryption_key_id = "s3EncryptionKeyId",
        .s_3_uri = "s3Uri",
    };
};
