/// The source identifying the inference connector.
pub const InferenceConnectorSource = struct {
    /// The identifier for the inference connector (for example, `bedrock-mantle`,
    /// `openai`, or `anthropic`).
    connector_id: []const u8,

    pub const json_field_names = .{
        .connector_id = "connectorId",
    };
};
