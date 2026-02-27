/// The target configuration for the MCP server.
pub const McpServerTargetConfiguration = struct {
    /// The endpoint for the MCP server target configuration.
    endpoint: []const u8,

    pub const json_field_names = .{
        .endpoint = "endpoint",
    };
};
