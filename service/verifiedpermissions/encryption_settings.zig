const Unit = @import("unit.zig").Unit;
const KmsEncryptionSettings = @import("kms_encryption_settings.zig").KmsEncryptionSettings;

/// A structure that contains the encryption configuration for the policy store
/// and child resources.
///
/// This data type is used as a request parameter in the
/// [CreatePolicyStore](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreatePolicyStore.html) operation.
pub const EncryptionSettings = union(enum) {
    /// This is the default encryption setting. The policy store uses an Amazon Web
    /// Services owned key for encrypting data.
    default: ?Unit,
    /// The KMS encryption settings for this policy store to encrypt data with. It
    /// will contain the customer-managed KMS key, and a user-defined encryption
    /// context.
    kms_encryption_settings: ?KmsEncryptionSettings,

    pub const json_field_names = .{
        .default = "default",
        .kms_encryption_settings = "kmsEncryptionSettings",
    };
};
