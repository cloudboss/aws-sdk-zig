const aws = @import("aws");

/// A structure that contains the KMS encryption configuration for the policy
/// store. The encryption state shows what customer-managed KMS key is being
/// used to encrypt all resources within the policy store, and any user-defined
/// context key-value pairs added during encryption processes.
///
/// This data type is used as a field that is part of the
/// [EncryptionState](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_EncryptionState.html) type.
pub const KmsEncryptionState = struct {
    /// User-defined, additional context added to encryption processes.
    encryption_context: []const aws.map.StringMapEntry,

    /// The customer-managed KMS key [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) being used for encryption processes.
    key: []const u8,

    pub const json_field_names = .{
        .encryption_context = "encryptionContext",
        .key = "key",
    };
};
