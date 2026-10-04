const FirewallRule = @import("firewall_rule.zig").FirewallRule;
const BatchUpdateFirewallRuleError = @import("batch_update_firewall_rule_error.zig").BatchUpdateFirewallRuleError;

pub const BatchUpdateFirewallRuleResponse = struct {
    /// The firewall rules that were successfully updated by the request.
    updated_firewall_rules: ?[]const FirewallRule = null,

    /// A list of errors that occurred while updating the firewall rules.
    update_errors: ?[]const BatchUpdateFirewallRuleError = null,

    pub const json_field_names = .{
        .updated_firewall_rules = "UpdatedFirewallRules",
        .update_errors = "UpdateErrors",
    };
};
