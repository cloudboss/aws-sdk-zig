const AdminFirewallTypeScope = @import("admin_firewall_type_scope.zig").AdminFirewallTypeScope;
const AdminScopeFilterInput = @import("admin_scope_filter_input.zig").AdminScopeFilterInput;

/// The administrative scope configuration provided on input, using account and
/// organizational unit IDs.
pub const AdminScopeInput = struct {
    /// The firewall types that the administrator can create and manage.
    firewall_type_scope: ?AdminFirewallTypeScope = null,

    /// The filter that determines which accounts and organizational units are in
    /// the administrator's scope.
    scope_filter: ?AdminScopeFilterInput = null,

    pub const json_field_names = .{
        .firewall_type_scope = "firewallTypeScope",
        .scope_filter = "scopeFilter",
    };
};
