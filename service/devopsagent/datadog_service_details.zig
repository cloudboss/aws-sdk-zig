const DatadogAuthorizationConfig = @import("datadog_authorization_config.zig").DatadogAuthorizationConfig;

/// Complete service details for Datadog MCP server integration.
pub const DatadogServiceDetails = struct {
    /// Datadog MCP server authorization configuration (only authorization discovery
    /// is supported).
    authorization_config: DatadogAuthorizationConfig,

    /// Optional description for the MCP server.
    description: ?[]const u8 = null,

    /// MCP server endpoint URL.
    endpoint: []const u8,

    /// MCP server name.
    name: []const u8,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
        .description = "description",
        .endpoint = "endpoint",
        .name = "name",
    };
};
