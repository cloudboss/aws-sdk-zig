const PagerDutyAuthorizationConfig = @import("pager_duty_authorization_config.zig").PagerDutyAuthorizationConfig;

/// Complete service details for PagerDuty integration
pub const PagerDutyDetails = struct {
    /// PagerDuty authorization configuration
    authorization_config: PagerDutyAuthorizationConfig,

    /// PagerDuty scopes.
    scopes: []const []const u8,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
        .scopes = "scopes",
    };
};
