const InvalidFirewallReasons = @import("invalid_firewall_reasons.zig").InvalidFirewallReasons;

/// Describes why a firewall is out of sync. Exactly one of `missingFirewall` or
/// `invalidFirewall` is set.
pub const FirewallSyncReason = union(enum) {
    /// Details about a firewall whose configuration does not match the intended
    /// configuration.
    invalid_firewall: ?InvalidFirewallReasons,
    /// Indicates that an expected firewall is missing. The value describes the
    /// missing firewall.
    missing_firewall: ?[]const u8,

    pub const json_field_names = .{
        .invalid_firewall = "invalidFirewall",
        .missing_firewall = "missingFirewall",
    };
};
