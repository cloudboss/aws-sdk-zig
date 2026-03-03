const RevealStatus = @import("reveal_status.zig").RevealStatus;

/// Specifies the status of the Amazon Macie configuration for retrieving
/// occurrences of sensitive data reported by findings, and the Key Management
/// Service (KMS) key to use to encrypt sensitive data that's retrieved. When
/// you enable the configuration for the first time, your request must specify
/// an KMS key. Otherwise, an error occurs.
pub const RevealConfiguration = struct {
    /// The Amazon Resource Name (ARN), ID, or alias of the KMS key to use to
    /// encrypt sensitive data that's retrieved. The key must be an existing,
    /// customer managed, symmetric encryption key that's enabled in the same Amazon
    /// Web Services Region as the Amazon Macie account.
    ///
    /// If this value specifies an alias, it must include the following prefix:
    /// alias/. If this value specifies a key that's owned by another Amazon Web
    /// Services account, it must specify the ARN of the key or the ARN of the key's
    /// alias.
    kms_key_id: ?[]const u8 = null,

    /// The status of the configuration for the Amazon Macie account. In a response,
    /// possible values are: ENABLED, the configuration is currently enabled for the
    /// account; and, DISABLED, the configuration is currently disabled for the
    /// account. In a request, valid values are: ENABLED, enable the configuration
    /// for the account; and, DISABLED, disable the configuration for the account.
    ///
    /// If you disable the configuration, you also permanently delete current
    /// settings that specify how to access affected S3 objects. If your current
    /// access method is ASSUME_ROLE, Macie also deletes the external ID and role
    /// name currently specified for the configuration. These settings can't be
    /// recovered after they're deleted.
    status: RevealStatus,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .status = "status",
    };
};
