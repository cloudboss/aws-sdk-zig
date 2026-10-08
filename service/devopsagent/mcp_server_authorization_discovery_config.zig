/// Authorization discovery configuration for MCP server.
pub const MCPServerAuthorizationDiscoveryConfig = struct {
    /// The endpoint to return to after OAuth flow completes (must be AWS console
    /// domain)
    return_to_endpoint: []const u8,

    pub const json_field_names = .{
        .return_to_endpoint = "returnToEndpoint",
    };
};
