/// A user's preference for using passkey, or WebAuthn, multi-factor
/// authentication
/// (MFA). Turns passkey MFA on and off for the user. Unlike other MFA settings
/// types,
/// this type doesn't include a `PreferredMfa` option because passkey MFA
/// applies only when passkey is the first authentication factor.
pub const WebAuthnMfaSettingsType = struct {
    /// Specifies whether passkey MFA is activated for a user. When activated, the
    /// user's
    /// passkey authentication requires user verification, and passkey sign-in is
    /// available
    /// when MFA is required. The user must also have at least one other MFA method
    /// such as
    /// SMS, TOTP, or email activated to prevent account lockout.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
