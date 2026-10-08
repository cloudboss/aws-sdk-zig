/// MCP tools descriptor containing tool definitions
pub const McpToolsDescriptor = struct {
    /// The MCP tools descriptor content, serialized as descriptor payload data.
    data: ?[]const u8 = null,

    /// The schema version of the descriptor payload.
    data_schema_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
    };
};
