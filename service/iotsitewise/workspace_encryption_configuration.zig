const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Contains the encryption configuration for a workspace.
pub const WorkspaceEncryptionConfiguration = struct {
    /// The encryption scheme for the workspace. `SITEWISE_DEFAULT_ENCRYPTION`
    /// encrypts data with the IoT SiteWise default key. `KMS_BASED_ENCRYPTION`
    /// encrypts data
    /// with the customer managed KMS key identified by `kmsKeyId`.
    encryption_type: EncryptionType,

    /// The customer managed KMS key used when `encryptionType` is
    /// `KMS_BASED_ENCRYPTION`. Accepts a key ID, key ARN, or key alias. Required
    /// for
    /// `KMS_BASED_ENCRYPTION`; must be omitted for
    /// `SITEWISE_DEFAULT_ENCRYPTION`. After a workspace's customer managed key
    /// configuration becomes active, the key can't be changed.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "encryptionType",
        .kms_key_id = "kmsKeyId",
    };
};
