const FirewallRule = @import("firewall_rule.zig").FirewallRule;
const BatchCreateFirewallRuleError = @import("batch_create_firewall_rule_error.zig").BatchCreateFirewallRuleError;

pub const BatchCreateFirewallRuleResponse = struct {
    /// The firewall rules that were successfully created by the request.
    created_firewall_rules: ?[]const FirewallRule = null,

    /// A list of errors that occurred while creating the firewall rules.
    create_errors: ?[]const BatchCreateFirewallRuleError = null,

    pub const json_field_names = .{
        .created_firewall_rules = "CreatedFirewallRules",
        .create_errors = "CreateErrors",
    };
};
