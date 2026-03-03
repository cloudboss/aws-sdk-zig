/// Provides the identifier of the KMS key used to encrypt data
/// indexed by Amazon Kendra. Amazon Kendra doesn't support asymmetric
/// keys.
pub const ServerSideEncryptionConfiguration = struct {
    /// The identifier of the KMS key. Amazon Kendra doesn't support
    /// asymmetric keys.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
    };
};
