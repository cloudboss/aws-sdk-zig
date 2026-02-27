/// Details about a node missing a required configuration.
pub const MissingNodeConfigurationFlowValidationDetails = struct {
    /// The name of the node missing a required configuration.
    node: []const u8,

    pub const json_field_names = .{
        .node = "node",
    };
};
