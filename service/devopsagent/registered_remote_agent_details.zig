const RemoteAgentAuthorizationMethod = @import("remote_agent_authorization_method.zig").RemoteAgentAuthorizationMethod;

/// Details specific to a registered token-based remote A2A agent.
pub const RegisteredRemoteAgentDetails = struct {
    /// If the remote agent uses API key authentication, the header name.
    api_key_header: ?[]const u8 = null,

    /// The authorization method used by the remote agent.
    authorization_method: RemoteAgentAuthorizationMethod,

    description: ?[]const u8 = null,

    endpoint: []const u8,

    name: []const u8,

    pub const json_field_names = .{
        .api_key_header = "apiKeyHeader",
        .authorization_method = "authorizationMethod",
        .description = "description",
        .endpoint = "endpoint",
        .name = "name",
    };
};
