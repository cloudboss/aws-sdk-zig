const DescriptorSource = @import("descriptor_source.zig").DescriptorSource;

/// Descriptor that defines the content of an A2A (Agent-to-Agent) agent card
/// registry record. The content is validated against the A2A protocol schema.
pub const A2aAgentCardDescriptor = struct {
    /// The A2A agent card content, serialized as descriptor payload data.
    data: ?[]const u8 = null,

    /// The schema version of the descriptor payload.
    data_schema_version: ?[]const u8 = null,

    /// The source location from which the A2A (Agent-to-Agent) agent card
    /// descriptor content was retrieved.
    source: ?DescriptorSource = null,

    pub const json_field_names = .{
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
        .source = "source",
    };
};
