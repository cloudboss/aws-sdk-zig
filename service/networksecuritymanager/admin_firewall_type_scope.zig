const PolicyFirewallType = @import("policy_firewall_type.zig").PolicyFirewallType;

/// Defines the firewall types that an administrator can create and manage.
pub const AdminFirewallTypeScope = struct {
    /// Specifies whether the administrator can manage all firewall types, except
    /// for third-party firewall types.
    all_firewall_types_enabled: ?bool = null,

    /// The list of firewall types that the administrator can manage.
    firewall_types: ?[]const PolicyFirewallType = null,

    pub const json_field_names = .{
        .all_firewall_types_enabled = "allFirewallTypesEnabled",
        .firewall_types = "firewallTypes",
    };
};
