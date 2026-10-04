const CreateFirewallRuleEntry = @import("create_firewall_rule_entry.zig").CreateFirewallRuleEntry;

pub const BatchCreateFirewallRuleRequest = struct {
    /// The list of firewall rules to create.
    create_firewall_rule_entries: []const CreateFirewallRuleEntry,

    pub const json_field_names = .{
        .create_firewall_rule_entries = "CreateFirewallRuleEntries",
    };
};
