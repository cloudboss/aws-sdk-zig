const aws = @import("aws");

/// A structure that contains the KMS encryption configuration for the policy
/// store. The encryption settings determine what customer-managed KMS key will
/// be used to encrypt all resources within the policy store, and any
/// user-defined context key-value pairs to append during encryption processes.
///
/// This data type is used as a field that is part of the
/// [EncryptionSettings](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_EncryptionSettings.html) type.
pub const KmsEncryptionSettings = struct {
    /// User-defined, additional context to be added to encryption processes.
    encryption_context: ?[]const aws.map.StringMapEntry,

    /// The customer-managed KMS key [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html), alias or ID to be used for encryption processes.
    ///
    /// Users can provide the full KMS key ARN, a KMS key alias, or a KMS key ID,
    /// but it will be mapped to the full KMS key ARN after policy store creation,
    /// and referenced when encrypting child resources.
    key: []const u8,

    pub const json_field_names = .{
        .encryption_context = "encryptionContext",
        .key = "key",
    };
};
