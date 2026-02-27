/// A user's preference for using SMS message multi-factor authentication (MFA).
/// Turns SMS
/// MFA on and off, and can set SMS as preferred when other MFA options are
/// available. You
/// can't turn off SMS MFA for any of your users when MFA is required in your
/// user pool; you
/// can only set the type that your user prefers.
pub const SMSMfaSettingsType = struct {
    /// Specifies whether SMS message MFA is activated. If an MFA type is activated
    /// for a
    /// user, the user will be prompted for MFA during all sign-in attempts, unless
    /// device
    /// tracking is turned on and the device has been trusted.
    enabled: bool = false,

    /// Specifies whether SMS is the preferred MFA method. If true, your user pool
    /// prompts the
    /// specified user for a code delivered by SMS message after username-password
    /// sign-in
    /// succeeds.
    preferred_mfa: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .preferred_mfa = "PreferredMfa",
    };
};
