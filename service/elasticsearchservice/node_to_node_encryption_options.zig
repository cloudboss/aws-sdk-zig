/// Specifies the node-to-node encryption options.
pub const NodeToNodeEncryptionOptions = struct {
    /// Specify true to enable node-to-node encryption.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
