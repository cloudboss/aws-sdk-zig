const RemoteAgentSigV4AuthorizationConfig = @import("remote_agent_sig_v4_authorization_config.zig").RemoteAgentSigV4AuthorizationConfig;

/// Complete service details for SigV4-authenticated remote A2A agent
/// integration.
pub const RemoteAgentSigV4ServiceDetails = struct {
    /// Remote agent SigV4 authorization configuration.
    authorization_config: RemoteAgentSigV4AuthorizationConfig,

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
