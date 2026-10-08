/// The server-side encryption configuration for a registry. Specifies a
/// customer-managed Amazon Web Services KMS key used to encrypt the registry's
/// content.
pub const EncryptionConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the customer-managed Amazon Web Services
    /// KMS key used to encrypt the registry's content. The key must be a symmetric
    /// encryption key in the same Amazon Web Services account and Region as the
    /// registry.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
    };
};
