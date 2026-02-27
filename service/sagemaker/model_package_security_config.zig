/// An optional Key Management Service key to encrypt, decrypt, and re-encrypt
/// model package information for regulated workloads with highly sensitive
/// data.
pub const ModelPackageSecurityConfig = struct {
    /// The KMS Key ID (`KMSKeyId`) used for encryption of model package
    /// information.
    kms_key_id: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
    };
};
