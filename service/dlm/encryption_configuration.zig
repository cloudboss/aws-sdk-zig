/// **[Event-based policies only]** Specifies the encryption settings for
/// cross-Region snapshot copies created by
/// event-based policies.
pub const EncryptionConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the KMS key to use for EBS encryption. If
    /// this parameter is not specified, the default KMS key for the account is
    /// used.
    cmk_arn: ?[]const u8 = null,

    /// To encrypt a copy of an unencrypted snapshot when encryption by default is
    /// not enabled, enable
    /// encryption using this parameter. Copies of encrypted snapshots are
    /// encrypted, even if this
    /// parameter is false or when encryption by default is not enabled.
    encrypted: bool,

    pub const json_field_names = .{
        .cmk_arn = "CmkArn",
        .encrypted = "Encrypted",
    };
};
