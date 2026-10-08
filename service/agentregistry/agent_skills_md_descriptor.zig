const DescriptorSource = @import("descriptor_source.zig").DescriptorSource;

/// Markdown-format descriptor containing an agent skills document.
pub const AgentSkillsMdDescriptor = struct {
    /// The agent skills markdown content, serialized as descriptor payload data.
    data: ?[]const u8 = null,

    /// The schema version of the descriptor payload.
    data_schema_version: ?[]const u8 = null,

    /// The source location from which the agent skills markdown content was
    /// retrieved.
    source: ?DescriptorSource = null,

    pub const json_field_names = .{
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
        .source = "source",
    };
};
