/// Identifies the Key Management Service (KMS) key used to encrypt the secrets.
pub const Provider = struct {
    /// Amazon Resource Name (ARN) or alias of the KMS key. The KMS key must be
    /// symmetric and created in
    /// the same Amazon Web Services Region as the cluster. If the KMS key was
    /// created in a different
    /// account, the [IAM
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html) must have access to the KMS key. For more information,
    /// see [Allowing
    /// users in other accounts to use a KMS
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-modifying-external-accounts.html) in the *Key Management Service
    /// Developer Guide*.
    key_arn: ?[]const u8,

    pub const json_field_names = .{
        .key_arn = "keyArn",
    };
};
