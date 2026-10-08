const RemoteAgentAPIKeyConfig = @import("remote_agent_api_key_config.zig").RemoteAgentAPIKeyConfig;
const RemoteAgentBearerTokenConfig = @import("remote_agent_bearer_token_config.zig").RemoteAgentBearerTokenConfig;
const RemoteAgentOAuthClientCredentialsConfig = @import("remote_agent_o_auth_client_credentials_config.zig").RemoteAgentOAuthClientCredentialsConfig;

/// Authorization configuration for remote A2A agents with token-based auth (API
/// key, OAuth, bearer token).
pub const RemoteAgentAuthorizationConfig = union(enum) {
    /// Remote agent configuration with API key authentication.
    api_key: ?RemoteAgentAPIKeyConfig,
    /// Remote agent configuration with Bearer token (RFC 6750).
    bearer_token: ?RemoteAgentBearerTokenConfig,
    /// Remote agent configuration with OAuth client credentials.
    o_auth_client_credentials: ?RemoteAgentOAuthClientCredentialsConfig,

    pub const json_field_names = .{
        .api_key = "apiKey",
        .bearer_token = "bearerToken",
        .o_auth_client_credentials = "oAuthClientCredentials",
    };
};
