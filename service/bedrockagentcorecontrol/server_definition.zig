/// The server definition for an MCP descriptor. Contains the schema version and
/// inline content for the MCP server configuration.
pub const ServerDefinition = struct {
    /// The JSON content containing the MCP server definition, conforming to the MCP
    /// protocol specification.
    inline_content: ?[]const u8 = null,

    /// The schema version of the server definition based on the MCP protocol
    /// specification. If not specified, the version is auto-detected from the
    /// content.
    schema_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
        .schema_version = "schemaVersion",
    };
};
