const AdvancedSecurityEnabledModeType = @import("advanced_security_enabled_mode_type.zig").AdvancedSecurityEnabledModeType;

/// Threat protection configuration options for additional authentication types
/// in your
/// user pool, including custom
/// authentication.
pub const AdvancedSecurityAdditionalFlowsType = struct {
    /// The operating mode of threat protection in custom authentication with [
    /// Custom
    /// authentication challenge Lambda
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).
    custom_auth_mode: ?AdvancedSecurityEnabledModeType = null,

    pub const json_field_names = .{
        .custom_auth_mode = "CustomAuthMode",
    };
};
