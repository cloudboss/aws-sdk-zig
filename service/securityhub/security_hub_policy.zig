const SecurityControlsConfiguration = @import("security_controls_configuration.zig").SecurityControlsConfiguration;

/// An object that defines how Security Hub is configured. The configuration
/// policy includes whether
/// Security Hub is enabled or disabled, a list of enabled security standards, a
/// list of enabled or
/// disabled security controls, and a list of custom parameter values for
/// specified controls. If you provide a list of security controls that are
/// enabled in the configuration
/// policy, Security Hub disables all other controls (including newly released
/// controls). If you provide a
/// list of security controls that are disabled in the configuration policy,
/// Security Hub enables all other
/// controls (including newly released controls).
pub const SecurityHubPolicy = struct {
    /// A list that defines which security standards are enabled in the
    /// configuration policy.
    enabled_standard_identifiers: ?[]const []const u8,

    /// An object that defines which security controls are enabled in the
    /// configuration policy. The enablement status
    /// of a control is aligned across all of the enabled standards in an account.
    security_controls_configuration: ?SecurityControlsConfiguration,

    /// Indicates whether Security Hub is enabled in the policy.
    service_enabled: ?bool,

    pub const json_field_names = .{
        .enabled_standard_identifiers = "EnabledStandardIdentifiers",
        .security_controls_configuration = "SecurityControlsConfiguration",
        .service_enabled = "ServiceEnabled",
    };
};
