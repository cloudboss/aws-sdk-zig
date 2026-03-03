/// A customer managed key structure that contains the information listed below:
///
/// * `KeyArn` - The ARN of a KMS key that is registered to a Quick Sight
///   account for encryption and decryption use.
///
/// * `DefaultKey` - Indicates whether the current key is set as the default key
///   for encryption and decryption use.
pub const RegisteredCustomerManagedKey = struct {
    /// Indicates whether a `RegisteredCustomerManagedKey` is set as the default key
    /// for encryption and decryption use.
    default_key: bool = false,

    /// The ARN of the KMS key that is registered to a Quick Sight account for
    /// encryption and decryption use.
    key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_key = "DefaultKey",
        .key_arn = "KeyArn",
    };
};
