/// The details for deleting a single firewall rule in a batch operation.
pub const DeleteFirewallRuleEntry = struct {
    /// The ID of the domain list that's used in the rule.
    firewall_domain_list_id: ?[]const u8 = null,

    /// The unique identifier of the firewall rule group for the rule.
    firewall_rule_group_id: []const u8,

    /// The ID of the DNS Firewall Advanced rule.
    firewall_threat_protection_id: ?[]const u8 = null,

    /// The DNS query type that the rule evaluates.
    qtype: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_domain_list_id = "FirewallDomainListId",
        .firewall_rule_group_id = "FirewallRuleGroupId",
        .firewall_threat_protection_id = "FirewallThreatProtectionId",
        .qtype = "Qtype",
    };
};
