/// The signing key used to cryptographically sign a support permit.
pub const SigningKeyInfo = union(enum) {
    /// The ARN of the AWS KMS key used to sign the permit. The key must have key
    /// spec ECC_NIST_P384 and key usage SIGN_VERIFY.
    kms_key: ?[]const u8,

    pub const json_field_names = .{
        .kms_key = "kmsKey",
    };
};
