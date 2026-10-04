const UpdateFirewallRuleEntry = @import("update_firewall_rule_entry.zig").UpdateFirewallRuleEntry;

pub const BatchUpdateFirewallRuleRequest = struct {
    /// The list of firewall rules to update.
    update_firewall_rule_entries: []const UpdateFirewallRuleEntry,

    pub const json_field_names = .{
        .update_firewall_rule_entries = "UpdateFirewallRuleEntries",
    };
};
