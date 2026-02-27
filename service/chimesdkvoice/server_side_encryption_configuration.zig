/// A structure that contains the configuration settings for server-side
/// encryption.
///
/// We only support symmetric keys. Do not use asymmetric or HMAC keys, or KMS
/// aliases.
pub const ServerSideEncryptionConfiguration = struct {
    /// The ARN of the KMS key used to encrypt the enrollment data in a voice
    /// profile domain.
    /// Asymmetric customer managed keys are not supported.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
    };
};
