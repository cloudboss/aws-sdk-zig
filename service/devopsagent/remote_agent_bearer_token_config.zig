/// Bearer token configuration for remote A2A agent (RFC 6750).
pub const RemoteAgentBearerTokenConfig = struct {
    /// HTTP header name to send the bearer token in requests to the service.
    /// Defaults to 'Authorization' per RFC 6750.
    authorization_header: []const u8 = "Authorization",

    /// User friendly bearer token name specified by end user.
    token_name: []const u8,

    /// Bearer token value in alphanumeric for authenticating with the service.
    token_value: []const u8,

    pub const json_field_names = .{
        .authorization_header = "authorizationHeader",
        .token_name = "tokenName",
        .token_value = "tokenValue",
    };
};
