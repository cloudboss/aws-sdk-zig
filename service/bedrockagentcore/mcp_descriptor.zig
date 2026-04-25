const ServerDefinition = @import("server_definition.zig").ServerDefinition;
const ToolsDefinition = @import("tools_definition.zig").ToolsDefinition;

/// The MCP (Model Context Protocol) descriptor configuration for a registry
/// record. Contains the server definition and tools definition.
pub const McpDescriptor = struct {
    /// The MCP server definition that describes the server configuration.
    server: ServerDefinition,

    /// The MCP tools definition that describes the available tools.
    tools: ToolsDefinition,

    pub const json_field_names = .{
        .server = "server",
        .tools = "tools",
    };
};
