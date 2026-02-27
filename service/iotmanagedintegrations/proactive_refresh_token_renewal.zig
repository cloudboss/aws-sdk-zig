/// Configuration settings for proactively refreshing OAuth tokens before they
/// expire.
pub const ProactiveRefreshTokenRenewal = struct {
    /// The days before token expiration when the system should attempt to renew the
    /// token, specified in days.
    days_before_renewal: ?i32,

    /// Indicates whether proactive refresh token renewal is enabled.
    enabled: ?bool,

    pub const json_field_names = .{
        .days_before_renewal = "DaysBeforeRenewal",
        .enabled = "enabled",
    };
};
