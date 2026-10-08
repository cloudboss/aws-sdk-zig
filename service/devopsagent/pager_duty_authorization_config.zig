const PagerDutyOAuthClientCredentialsConfig = @import("pager_duty_o_auth_client_credentials_config.zig").PagerDutyOAuthClientCredentialsConfig;

/// Authorization configuration options for PagerDuty service.
pub const PagerDutyAuthorizationConfig = union(enum) {
    /// OAuth client credentials configuration.
    o_auth_client_credentials: ?PagerDutyOAuthClientCredentialsConfig,

    pub const json_field_names = .{
        .o_auth_client_credentials = "oAuthClientCredentials",
    };
};
