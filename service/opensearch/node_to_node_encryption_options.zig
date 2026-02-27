/// Enables or disables node-to-node encryption. For more information, see
/// [Node-to-node encryption for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ntn.html).
pub const NodeToNodeEncryptionOptions = struct {
    /// True to enable node-to-node encryption.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
