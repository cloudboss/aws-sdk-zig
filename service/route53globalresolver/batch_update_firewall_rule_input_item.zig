const FirewallRuleAction = @import("firewall_rule_action.zig").FirewallRuleAction;
const BlockOverrideDnsQueryType = @import("block_override_dns_query_type.zig").BlockOverrideDnsQueryType;
const FirewallBlockResponse = @import("firewall_block_response.zig").FirewallBlockResponse;
const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;
const DnsAdvancedProtection = @import("dns_advanced_protection.zig").DnsAdvancedProtection;

/// Information for updating a firewall rule in a batch operation.
pub const BatchUpdateFirewallRuleInputItem = struct {
    /// The action to take when a DNS query matches the firewall rule.
    action: ?FirewallRuleAction = null,

    /// The DNS record type for the custom response when the action is BLOCK.
    block_override_dns_type: ?BlockOverrideDnsQueryType = null,

    /// The custom domain name for the BLOCK response.
    block_override_domain: ?[]const u8 = null,

    /// The TTL value for the custom response when the action is BLOCK.
    block_override_ttl: ?i32 = null,

    /// The type of block response to return when the action is BLOCK.
    block_response: ?FirewallBlockResponse = null,

    /// The confidence threshold for advanced threat detection.
    confidence_threshold: ?ConfidenceThreshold = null,

    /// A description of the firewall rule.
    description: ?[]const u8 = null,

    /// Whether to enable advanced DNS threat protection for the firewall rule.
    dns_advanced_protection: ?DnsAdvancedProtection = null,

    /// The unique identifier of the firewall rule to update.
    firewall_rule_id: []const u8,

    /// A name for the firewall rule.
    name: ?[]const u8 = null,

    /// The priority of the firewall rule.
    priority: ?i64 = null,

    pub const json_field_names = .{
        .action = "action",
        .block_override_dns_type = "blockOverrideDnsType",
        .block_override_domain = "blockOverrideDomain",
        .block_override_ttl = "blockOverrideTtl",
        .block_response = "blockResponse",
        .confidence_threshold = "confidenceThreshold",
        .description = "description",
        .dns_advanced_protection = "dnsAdvancedProtection",
        .firewall_rule_id = "firewallRuleId",
        .name = "name",
        .priority = "priority",
    };
};
