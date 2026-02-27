const Unit = @import("unit.zig").Unit;
const KmsEncryptionState = @import("kms_encryption_state.zig").KmsEncryptionState;

/// A structure that contains the encryption configuration for the policy store
/// and child resources.
///
/// This data type is used as a response parameter field for the
/// [GetPolicyStore](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_GetPolicyStore.html) operation.
pub const EncryptionState = union(enum) {
    /// This is the default encryption state. The policy store is encrypted using an
    /// Amazon Web Services owned key.
    default: ?Unit,
    /// The KMS encryption settings currently configured for this policy store to
    /// encrypt data with. It contains the customer-managed KMS key, and a
    /// user-defined encryption context.
    kms_encryption_state: ?KmsEncryptionState,

    pub const json_field_names = .{
        .default = "default",
        .kms_encryption_state = "kmsEncryptionState",
    };
};
