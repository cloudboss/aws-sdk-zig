const McpServerAdditionalData = @import("mcp_server_additional_data.zig").McpServerAdditionalData;
const DescriptorSource = @import("descriptor_source.zig").DescriptorSource;

/// Descriptor that defines the content of an MCP (Model Context Protocol)
/// server registry record, including the server definition and its tool
/// definitions. The content is validated against the MCP protocol schema.
pub const McpServerDescriptor = struct {
    /// Additional data associated with the MCP server descriptor, such as tool
    /// definitions.
    additional_data: ?McpServerAdditionalData = null,

    /// The MCP server descriptor content, serialized as descriptor payload data.
    data: ?[]const u8 = null,

    /// The schema version of the descriptor payload.
    data_schema_version: ?[]const u8 = null,

    /// The source location from which the MCP (Model Context Protocol) server
    /// descriptor content was retrieved.
    source: ?DescriptorSource = null,

    pub const json_field_names = .{
        .additional_data = "additionalData",
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
        .source = "source",
    };
};
