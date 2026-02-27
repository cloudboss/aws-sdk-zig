/// Settings for time-based one-time password (TOTP) multi-factor authentication
/// (MFA) in
/// a user pool. Enables and disables availability of this feature.
pub const SoftwareTokenMfaConfigType = struct {
    /// The activation state of TOTP MFA.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
