/// User preferences for multi-factor authentication with email messages.
/// Activates or
/// deactivates email MFA and sets it as the preferred MFA method when multiple
/// methods are
/// available. To activate this setting, your user pool must be in the [
/// Essentials
/// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-essentials.html) or higher.
pub const EmailMfaSettingsType = struct {
    /// Specifies whether email message MFA is active for a user. When the value of
    /// this
    /// parameter is `Enabled`, the user will be prompted for MFA during all sign-in
    /// attempts, unless device tracking is turned on and the device has been
    /// trusted.
    enabled: bool = false,

    /// Specifies whether email message MFA is the user's preferred method.
    preferred_mfa: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .preferred_mfa = "PreferredMfa",
    };
};
