const AgentSkillsAdditionalData = @import("agent_skills_additional_data.zig").AgentSkillsAdditionalData;

/// Descriptor that defines an agent skills registry record and its associated
/// content.
pub const AgentSkillsDefinitionDescriptor = struct {
    /// Additional data for the agent skills definition, such as the skills markdown
    /// descriptor.
    additional_data: ?AgentSkillsAdditionalData = null,

    /// The agent skills definition content, serialized as descriptor payload data.
    data: ?[]const u8 = null,

    /// The schema version of the descriptor payload.
    data_schema_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_data = "additionalData",
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
    };
};
