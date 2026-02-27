const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Configuration for encrypting workflow data at rest and in transit. Amazon
/// Managed Workflows for Apache Airflow Serverless provides comprehensive
/// encryption capabilities to protect sensitive workflow data, parameters, and
/// execution logs. When using customer-managed keys, the service integrates
/// with Amazon Web Services KMS to provide fine-grained access control and
/// audit capabilities. Encryption is applied consistently across the
/// distributed execution environment including task containers, metadata
/// storage, and log streams.
pub const EncryptionConfiguration = struct {
    /// The ID or ARN of the Amazon Web Services KMS key to use for encryption.
    /// Required when `Type` is `CUSTOMER_MANAGED_KEY`.
    kms_key_id: ?[]const u8,

    /// The type of encryption to use. Values are `AWS_MANAGED_KEY` (Amazon Web
    /// Services manages the encryption key) or `CUSTOMER_MANAGED_KEY` (you provide
    /// a KMS key).
    type: EncryptionType,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .type = "Type",
    };
};
