const FirewallRule = @import("firewall_rule.zig").FirewallRule;

pub const UpdateFirewallRuleResponse = struct {
    /// The firewall rule that you just updated.
    firewall_rule: ?FirewallRule,

    pub const json_field_names = .{
        .firewall_rule = "FirewallRule",
    };
};
