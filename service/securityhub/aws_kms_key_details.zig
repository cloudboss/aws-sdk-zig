/// Contains metadata about an KMS key.
pub const AwsKmsKeyDetails = struct {
    /// The twelve-digit account ID of the Amazon Web Services account that owns the
    /// KMS key.
    aws_account_id: ?[]const u8 = null,

    /// Indicates when the KMS key was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    creation_date: ?f64 = null,

    /// A description of the KMS key.
    description: ?[]const u8 = null,

    /// The globally unique identifier for the KMS key.
    key_id: ?[]const u8 = null,

    /// The manager of the KMS key. KMS keys in your Amazon Web Services account are
    /// either customer managed or Amazon Web Services managed.
    key_manager: ?[]const u8 = null,

    /// Whether the key has key rotation enabled.
    key_rotation_status: ?bool = null,

    /// The state of the KMS key. Valid values are as follows:
    ///
    /// * `Disabled`
    ///
    /// * `Enabled`
    ///
    /// * `PendingDeletion`
    ///
    /// * `PendingImport`
    ///
    /// * `Unavailable`
    key_state: ?[]const u8 = null,

    /// The source of the KMS key material.
    ///
    /// When this value is `AWS_KMS`, KMS created the key material.
    ///
    /// When this value is `EXTERNAL`, the key material was imported from your
    /// existing key management infrastructure or the KMS key lacks key material.
    ///
    /// When this value is `AWS_CLOUDHSM`, the key material was created in the
    /// CloudHSM cluster associated with a custom key store.
    origin: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AWSAccountId",
        .creation_date = "CreationDate",
        .description = "Description",
        .key_id = "KeyId",
        .key_manager = "KeyManager",
        .key_rotation_status = "KeyRotationStatus",
        .key_state = "KeyState",
        .origin = "Origin",
    };
};
