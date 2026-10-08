const DynatraceServiceAuthorizationConfig = @import("dynatrace_service_authorization_config.zig").DynatraceServiceAuthorizationConfig;

/// Complete service details for Dynatrace integration.
pub const DynatraceServiceDetails = struct {
    /// Dynatrace resource account urn.
    account_urn: []const u8,

    /// Dynatrace OAuth client credentials configuration. Use this when registering
    /// with OAuth client credentials flow.
    authorization_config: ?DynatraceServiceAuthorizationConfig = null,

    pub const json_field_names = .{
        .account_urn = "accountUrn",
        .authorization_config = "authorizationConfig",
    };
};
