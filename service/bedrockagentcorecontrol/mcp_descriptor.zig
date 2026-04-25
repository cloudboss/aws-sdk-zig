const ServerDefinition = @import("server_definition.zig").ServerDefinition;
const ToolsDefinition = @import("tools_definition.zig").ToolsDefinition;

/// The Model Context Protocol (MCP) descriptor for a registry record. Contains
/// the server definition and tools definition for an MCP-compatible server. The
/// schema is validated against the MCP protocol specification.
pub const McpDescriptor = struct {
    /// The MCP server definition, containing the server configuration and schema as
    /// defined by the MCP protocol specification.
    server: ?ServerDefinition = null,

    /// The MCP tools definition, containing the tools available on the MCP server
    /// as defined by the MCP protocol specification.
    tools: ?ToolsDefinition = null,

    pub const json_field_names = .{
        .server = "server",
        .tools = "tools",
    };
};
