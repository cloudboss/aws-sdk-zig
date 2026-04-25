/// The agent card definition for A2A descriptors, including the schema version
/// and inline content that describes the agent's capabilities.
pub const AgentCardDefinition = struct {
    /// The inline content of the agent card definition.
    inline_content: ?[]const u8 = null,

    /// The schema version of the agent card definition.
    schema_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
        .schema_version = "schemaVersion",
    };
};
