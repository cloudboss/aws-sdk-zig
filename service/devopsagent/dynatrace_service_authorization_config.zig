const DynatraceOAuthClientCredentialsConfig = @import("dynatrace_o_auth_client_credentials_config.zig").DynatraceOAuthClientCredentialsConfig;

/// Authorization configuration options for Dynatrace service.
pub const DynatraceServiceAuthorizationConfig = union(enum) {
    /// OAuth client credentials configuration.
    o_auth_client_credentials: ?DynatraceOAuthClientCredentialsConfig,

    pub const json_field_names = .{
        .o_auth_client_credentials = "oAuthClientCredentials",
    };
};
