/// The tools definition for an MCP descriptor. Contains the protocol version
/// and inline content describing the available tools.
pub const ToolsDefinition = struct {
    /// The JSON content containing the MCP tools definition, conforming to the MCP
    /// protocol specification.
    inline_content: ?[]const u8 = null,

    /// The protocol version of the tools definition based on the MCP protocol
    /// specification. If not specified, the version is auto-detected from the
    /// content.
    protocol_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .inline_content = "inlineContent",
        .protocol_version = "protocolVersion",
    };
};
