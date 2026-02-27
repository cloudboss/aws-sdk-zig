const McpTargetConfiguration = @import("mcp_target_configuration.zig").McpTargetConfiguration;

/// The configuration for a gateway target. This structure defines how the
/// gateway connects to and interacts with the target endpoint.
pub const TargetConfiguration = union(enum) {
    /// The Model Context Protocol (MCP) configuration for the target. This
    /// configuration defines how the gateway uses MCP to communicate with the
    /// target.
    mcp: ?McpTargetConfiguration,

    pub const json_field_names = .{
        .mcp = "mcp",
    };
};
