const ServiceNowOAuthClientCredentialsConfig = @import("service_now_o_auth_client_credentials_config.zig").ServiceNowOAuthClientCredentialsConfig;

/// Authorization configuration options for ServiceNow service.
pub const ServiceNowServiceAuthorizationConfig = union(enum) {
    /// OAuth client credentials configuration.
    o_auth_client_credentials: ?ServiceNowOAuthClientCredentialsConfig,

    pub const json_field_names = .{
        .o_auth_client_credentials = "oAuthClientCredentials",
    };
};
