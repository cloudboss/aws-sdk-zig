/// A user's preference for using time-based one-time password (TOTP)
/// multi-factor
/// authentication (MFA). Turns TOTP MFA on and off, and can set TOTP as
/// preferred when
/// other MFA options are available. You can't turn off TOTP MFA for any of your
/// users when
/// MFA is required in your user pool; you can only set the type that your user
/// prefers.
pub const SoftwareTokenMfaSettingsType = struct {
    /// Specifies whether software token MFA is activated. If an MFA type is
    /// activated for a
    /// user, the user will be prompted for MFA during all sign-in attempts, unless
    /// device
    /// tracking is turned on and the device has been trusted.
    enabled: bool = false,

    /// Specifies whether software token MFA is the preferred MFA method.
    preferred_mfa: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .preferred_mfa = "PreferredMfa",
    };
};
