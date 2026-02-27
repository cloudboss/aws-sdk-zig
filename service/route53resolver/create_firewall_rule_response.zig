const FirewallRule = @import("firewall_rule.zig").FirewallRule;

pub const CreateFirewallRuleResponse = struct {
    /// The firewall rule that you just created.
    firewall_rule: ?FirewallRule,

    pub const json_field_names = .{
        .firewall_rule = "FirewallRule",
    };
};
