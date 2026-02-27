/// Information about a DNS Firewall rule to delete in a batch operation.
pub const BatchDeleteFirewallRuleInputItem = struct {
    /// The ID of the DNS Firewall rule to delete.
    firewall_rule_id: []const u8,

    pub const json_field_names = .{
        .firewall_rule_id = "firewallRuleId",
    };
};
