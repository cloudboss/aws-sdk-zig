/// Asynchronous invocation output data settings.
pub const AsyncInvokeS3OutputDataConfig = struct {
    /// If the bucket belongs to another AWS account, specify that account's ID.
    bucket_owner: ?[]const u8,

    /// A KMS encryption key ID.
    kms_key_id: ?[]const u8,

    /// An object URI starting with `s3://`.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .bucket_owner = "bucketOwner",
        .kms_key_id = "kmsKeyId",
        .s_3_uri = "s3Uri",
    };
};
