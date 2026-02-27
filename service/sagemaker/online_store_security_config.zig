/// The security configuration for `OnlineStore`.
pub const OnlineStoreSecurityConfig = struct {
    /// The Amazon Web Services Key Management Service (KMS) key ARN that SageMaker
    /// Feature Store uses to encrypt the Amazon S3 objects at rest using Amazon S3
    /// server-side encryption.
    ///
    /// The caller (either user or IAM role) of `CreateFeatureGroup` must have below
    /// permissions to the `OnlineStore` `KmsKeyId`:
    ///
    /// * `"kms:Encrypt"`
    /// * `"kms:Decrypt"`
    /// * `"kms:DescribeKey"`
    /// * `"kms:CreateGrant"`
    /// * `"kms:RetireGrant"`
    /// * `"kms:ReEncryptFrom"`
    /// * `"kms:ReEncryptTo"`
    /// * `"kms:GenerateDataKey"`
    /// * `"kms:ListAliases"`
    /// * `"kms:ListGrants"`
    /// * `"kms:RevokeGrant"`
    ///
    /// The caller (either user or IAM role) to all DataPlane operations
    /// (`PutRecord`, `GetRecord`, `DeleteRecord`) must have the following
    /// permissions to the `KmsKeyId`:
    ///
    /// * `"kms:Decrypt"`
    kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
    };
};
