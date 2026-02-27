/// Specifies the method used to encrypt the user’s data stores in the Athena
/// workgroup.
pub const AwsAthenaWorkGroupConfigurationResultConfigurationEncryptionConfigurationDetails = struct {
    /// Indicates whether Amazon Simple Storage Service (Amazon S3) server-side
    /// encryption with Amazon S3 managed
    /// keys (SSE_S3), server-side encryption with KMS keys (SSE_KMS), or
    /// client-side encryption with
    /// KMS customer managed keys (CSE_KMS) is used.
    encryption_option: ?[]const u8,

    /// For `SSE_KMS` and `CSE_KMS`, this is the KMS key Amazon Resource Name (ARN)
    /// or ID.
    kms_key: ?[]const u8,

    pub const json_field_names = .{
        .encryption_option = "EncryptionOption",
        .kms_key = "KmsKey",
    };
};
