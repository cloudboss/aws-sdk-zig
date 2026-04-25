/// The MCP tools definition with a protocol version and inline content. The
/// `protocolVersion` identifies the MCP protocol version that the tools conform
/// to. This differs from `schemaVersion` in the server definition, which
/// identifies the server configuration schema format.
pub const ToolsDefinition = struct {
    /// The inline content of the tools definition.
    inline_content: ?[]const u8 = null,

    /// The MCP protocol version that the tools conform to. This differs from the
    /// `schemaVersion` field in the server definition, which identifies the server
    /// configuration schema format.
    protocol_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
        .protocol_version = "protocolVersion",
    };
};
