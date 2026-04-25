/// The agent card definition for an A2A descriptor. Contains the schema version
/// and inline content for the agent card.
pub const AgentCardDefinition = struct {
    /// The JSON content containing the A2A agent card definition, conforming to the
    /// A2A protocol specification.
    inline_content: ?[]const u8 = null,

    /// The schema version of the agent card based on the A2A protocol
    /// specification.
    schema_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
        .schema_version = "schemaVersion",
    };
};
