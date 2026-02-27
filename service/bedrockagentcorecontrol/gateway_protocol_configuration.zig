const MCPGatewayConfiguration = @import("mcp_gateway_configuration.zig").MCPGatewayConfiguration;

/// The configuration for a gateway protocol. This structure defines how the
/// gateway communicates with external services.
pub const GatewayProtocolConfiguration = union(enum) {
    /// The configuration for the Model Context Protocol (MCP). This protocol
    /// enables communication between Amazon Bedrock Agent and external tools.
    mcp: ?MCPGatewayConfiguration,

    pub const json_field_names = .{
        .mcp = "mcp",
    };
};
