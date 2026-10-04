const aws = @import("aws");

/// Encryption configuration for the invocation
pub const EncryptionConfiguration = struct {
    /// A map of plain text, non-secret key:value pairs, known as encryption context
    /// pairs, that provide an added layer of security for your data. For more
    /// information, see [KMS encryption
    /// context](https://docs.aws.amazon.com/transcribe/latest/dg/key-management.html#kms-context).
    kms_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the KMS key you want to use to encrypt
    /// your resource artifacts. Only full KMS key ARN format is supported.
    ///
    /// KMS key ARNs have the format `arn:partition:kms:region:account:key/key-id`.
    /// For example:
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    ///
    /// For more information, see [KMS key
    /// ARNs](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN).
    kms_key: []const u8,

    pub const json_field_names = .{
        .kms_encryption_context = "KMSEncryptionContext",
        .kms_key = "KMSKey",
    };
};
