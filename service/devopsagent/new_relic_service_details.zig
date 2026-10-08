const NewRelicServiceAuthorizationConfig = @import("new_relic_service_authorization_config.zig").NewRelicServiceAuthorizationConfig;

/// Complete service details for New Relic integration.
pub const NewRelicServiceDetails = struct {
    /// New Relic MCP server authorization configuration.
    authorization_config: NewRelicServiceAuthorizationConfig,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
    };
};
