/// Encryption settings for a collection.
pub const EncryptionConfig = struct {
    /// Indicates whether to use an Amazon Web Services-owned key for encryption.
    a_ws_owned_key: ?bool,

    /// The ARN of the Amazon Web Services Key Management Service key used to
    /// encrypt the collection.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .a_ws_owned_key = "aWSOwnedKey",
        .kms_key_arn = "kmsKeyArn",
    };
};
