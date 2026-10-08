const ServiceNowServiceAuthorizationConfig = @import("service_now_service_authorization_config.zig").ServiceNowServiceAuthorizationConfig;

/// Complete service details for ServiceNow integration.
pub const ServiceNowServiceDetails = struct {
    /// ServiceNow OAuth client credentials configuration. Use this when registering
    /// with OAuth client credentials flow.
    authorization_config: ?ServiceNowServiceAuthorizationConfig = null,

    /// ServiceNow instance URL.
    instance_url: []const u8,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
        .instance_url = "instanceUrl",
    };
};
