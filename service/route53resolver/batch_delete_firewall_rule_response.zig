const FirewallRule = @import("firewall_rule.zig").FirewallRule;
const BatchDeleteFirewallRuleError = @import("batch_delete_firewall_rule_error.zig").BatchDeleteFirewallRuleError;

pub const BatchDeleteFirewallRuleResponse = struct {
    /// The firewall rules that were successfully deleted by the request.
    deleted_firewall_rules: ?[]const FirewallRule = null,

    /// A list of errors that occurred while deleting the firewall rules.
    delete_errors: ?[]const BatchDeleteFirewallRuleError = null,

    pub const json_field_names = .{
        .deleted_firewall_rules = "DeletedFirewallRules",
        .delete_errors = "DeleteErrors",
    };
};
