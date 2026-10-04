/// Contains the KMS key configuration for a JWT client assertion.
pub const KmsKeySourceType = struct {
    /// The Amazon Resource Name (ARN) of the KMS key used to sign the JWT client
    /// assertion. The key must be an asymmetric key with key usage SIGN_VERIFY and
    /// a key spec compatible with the configured signing algorithm.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
    };
};
