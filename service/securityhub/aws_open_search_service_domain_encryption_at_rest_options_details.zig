/// Details about the configuration for encryption at rest for the OpenSearch
/// domain.
pub const AwsOpenSearchServiceDomainEncryptionAtRestOptionsDetails = struct {
    /// Whether encryption at rest is enabled.
    enabled: ?bool,

    /// The KMS key ID.
    kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .kms_key_id = "KmsKeyId",
    };
};
