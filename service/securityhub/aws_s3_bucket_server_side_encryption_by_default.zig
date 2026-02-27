/// Specifies the default server-side encryption to apply to new objects in the
/// bucket.
pub const AwsS3BucketServerSideEncryptionByDefault = struct {
    /// KMS key ID to use for the default encryption.
    kms_master_key_id: ?[]const u8,

    /// Server-side encryption algorithm to use for the default encryption. Valid
    /// values are
    /// `aws: kms` or `AES256`.
    sse_algorithm: ?[]const u8,

    pub const json_field_names = .{
        .kms_master_key_id = "KMSMasterKeyID",
        .sse_algorithm = "SSEAlgorithm",
    };
};
