const DeleteFirewallRuleEntry = @import("delete_firewall_rule_entry.zig").DeleteFirewallRuleEntry;

pub const BatchDeleteFirewallRuleRequest = struct {
    /// The list of firewall rules to delete.
    delete_firewall_rule_entries: []const DeleteFirewallRuleEntry,

    pub const json_field_names = .{
        .delete_firewall_rule_entries = "DeleteFirewallRuleEntries",
    };
};
