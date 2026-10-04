const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Contains the encryption configuration information for a workspace.
pub const WorkspaceEncryptionConfigurationInfo = struct {
    /// The type of encryption used for the workspace.
    encryption_type: EncryptionType,

    /// The key ARN of the KMS key used for KMS encryption if `encryptionType`
    /// is `KMS_BASED_ENCRYPTION`.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "encryptionType",
        .kms_key_arn = "kmsKeyArn",
    };
};
