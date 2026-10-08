const DescriptorSource = @import("descriptor_source.zig").DescriptorSource;

/// Markdown-format descriptor containing an agent skills document.
pub const AgentSkillsMdDescriptor = struct {
    /// The agent skills markdown content, serialized as descriptor payload data.
    data: ?[]const u8 = null,

    /// The schema version of the descriptor payload.
    data_schema_version: ?[]const u8 = null,

    /// The optional source configuration used to synchronize the agent skills
    /// markdown content.
    source: ?DescriptorSource = null,

    pub const json_field_names = .{
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
        .source = "source",
    };
};
