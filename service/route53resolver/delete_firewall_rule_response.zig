const FirewallRule = @import("firewall_rule.zig").FirewallRule;

pub const DeleteFirewallRuleResponse = struct {
    /// The specification for the firewall rule that you just deleted.
    firewall_rule: ?FirewallRule,

    pub const json_field_names = .{
        .firewall_rule = "FirewallRule",
    };
};
