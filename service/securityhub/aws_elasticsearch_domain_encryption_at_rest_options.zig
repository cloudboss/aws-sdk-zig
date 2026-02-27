/// Details about the configuration for encryption at rest.
pub const AwsElasticsearchDomainEncryptionAtRestOptions = struct {
    /// Whether encryption at rest is enabled.
    enabled: ?bool,

    /// The KMS key ID. Takes the form `1a2a3a4-1a2a-3a4a-5a6a-1a2a3a4a5a6a`.
    kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .kms_key_id = "KmsKeyId",
    };
};
