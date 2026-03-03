const AutomaticUpdatePolicy = @import("automatic_update_policy.zig").AutomaticUpdatePolicy;

/// A set of variables indicating the software update preferences for the
/// gateway.
pub const SoftwareUpdatePreferences = struct {
    /// Indicates the automatic update policy for a gateway.
    ///
    /// `ALL_VERSIONS` - Enables regular gateway maintenance updates.
    ///
    /// `EMERGENCY_VERSIONS_ONLY` - Disables regular gateway maintenance updates.
    /// The
    /// gateway will still receive emergency version updates on rare occasions if
    /// necessary to
    /// remedy highly critical security or durability issues. You will be notified
    /// before an
    /// emergency version update is applied. These updates are applied during your
    /// gateway's
    /// scheduled maintenance window.
    automatic_update_policy: ?AutomaticUpdatePolicy = null,

    pub const json_field_names = .{
        .automatic_update_policy = "AutomaticUpdatePolicy",
    };
};
