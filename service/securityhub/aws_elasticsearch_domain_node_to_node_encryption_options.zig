/// Details about the configuration for node-to-node encryption.
pub const AwsElasticsearchDomainNodeToNodeEncryptionOptions = struct {
    /// Whether node-to-node encryption is enabled.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
