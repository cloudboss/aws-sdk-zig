/// Configuration for ServiceNow instance integration.
pub const ServiceNowConfiguration = struct {
    /// Scoped down authentication scopes for fine grained control
    auth_scopes: ?[]const []const u8 = null,

    /// ServiceNow instance ID
    instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_scopes = "authScopes",
        .instance_id = "instanceId",
    };
};
