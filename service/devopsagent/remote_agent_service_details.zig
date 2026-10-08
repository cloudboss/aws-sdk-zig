const RemoteAgentAuthorizationConfig = @import("remote_agent_authorization_config.zig").RemoteAgentAuthorizationConfig;

/// Complete service details for token-based remote A2A agent integration.
pub const RemoteAgentServiceDetails = struct {
    /// Remote agent authorization configuration.
    authorization_config: RemoteAgentAuthorizationConfig,

    description: ?[]const u8 = null,

    endpoint: []const u8,

    name: []const u8,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
        .description = "description",
        .endpoint = "endpoint",
        .name = "name",
    };
};
