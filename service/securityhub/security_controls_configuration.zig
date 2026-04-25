const SecurityControlCustomParameter = @import("security_control_custom_parameter.zig").SecurityControlCustomParameter;

/// An object that defines which security controls are enabled in an Security
/// Hub CSPM configuration policy.
/// The enablement status of a control is aligned across all of the enabled
/// standards in an account.
pub const SecurityControlsConfiguration = struct {
    /// A list of security controls that are disabled in the configuration policy.
    /// Security Hub CSPM enables all other
    /// controls (including newly released controls) other than the listed controls.
    disabled_security_control_identifiers: ?[]const []const u8 = null,

    /// A list of security controls that are enabled in the configuration policy.
    /// Security Hub CSPM disables all other
    /// controls (including newly released controls) other than the listed controls.
    enabled_security_control_identifiers: ?[]const []const u8 = null,

    /// A list of security controls and control parameter values that are included
    /// in a configuration policy.
    security_control_custom_parameters: ?[]const SecurityControlCustomParameter = null,

    pub const json_field_names = .{
        .disabled_security_control_identifiers = "DisabledSecurityControlIdentifiers",
        .enabled_security_control_identifiers = "EnabledSecurityControlIdentifiers",
        .security_control_custom_parameters = "SecurityControlCustomParameters",
    };
};
