const ExternalIdType = @import("external_id_type.zig").ExternalIdType;

/// The configuration of the Amazon Web Services Key Management Service (KMS)
/// encryption key to use for an Autonomous Database.
pub const AwsEncryptionKeyConfigurationInput = struct {
    /// The type of external identifier associated with the encryption key.
    external_id_type: ?ExternalIdType = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Identity and
    /// Access Management (IAM) role that grants access to the KMS key.
    iam_role_arn: ?[]const u8 = null,

    /// The identifier or ARN of the Amazon Web Services KMS key to use for
    /// encryption.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .external_id_type = "externalIdType",
        .iam_role_arn = "iamRoleArn",
        .kms_key_id = "kmsKeyId",
    };
};
