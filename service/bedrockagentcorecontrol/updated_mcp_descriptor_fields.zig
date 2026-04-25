const UpdatedServerDefinition = @import("updated_server_definition.zig").UpdatedServerDefinition;
const UpdatedToolsDefinition = @import("updated_tools_definition.zig").UpdatedToolsDefinition;

/// Individual MCP descriptor fields that can be updated independently.
pub const UpdatedMcpDescriptorFields = struct {
    /// The updated server definition for the MCP descriptor.
    server: ?UpdatedServerDefinition = null,

    /// The updated tools definition for the MCP descriptor.
    tools: ?UpdatedToolsDefinition = null,

    pub const json_field_names = .{
        .server = "server",
        .tools = "tools",
    };
};
