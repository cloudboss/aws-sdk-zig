/// The MCP server definition with a schema version and inline content. The
/// `schemaVersion` identifies the version of the MCP server configuration
/// schema.
pub const ServerDefinition = struct {
    /// The inline content of the server definition.
    inline_content: ?[]const u8 = null,

    /// The schema version of the MCP server configuration. The schema version
    /// identifies the format of the server definition content.
    schema_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
        .schema_version = "schemaVersion",
    };
};
