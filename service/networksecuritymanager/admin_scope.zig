const AdminFirewallTypeScope = @import("admin_firewall_type_scope.zig").AdminFirewallTypeScope;
const AdminScopeFilter = @import("admin_scope_filter.zig").AdminScopeFilter;

/// Defines the accounts, organizational units, and firewall types that an
/// administrator can manage.
pub const AdminScope = struct {
    /// The firewall types that the administrator can create and manage.
    firewall_type_scope: ?AdminFirewallTypeScope = null,

    /// The filter that determines which accounts and organizational units are in
    /// the administrator's scope.
    scope_filter: ?AdminScopeFilter = null,

    pub const json_field_names = .{
        .firewall_type_scope = "firewallTypeScope",
        .scope_filter = "scopeFilter",
    };
};
