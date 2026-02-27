const FirewallRuleAction = @import("firewall_rule_action.zig").FirewallRuleAction;
const BlockOverrideDnsQueryType = @import("block_override_dns_query_type.zig").BlockOverrideDnsQueryType;
const FirewallBlockResponse = @import("firewall_block_response.zig").FirewallBlockResponse;
const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;
const DnsAdvancedProtection = @import("dns_advanced_protection.zig").DnsAdvancedProtection;

/// Information about a DNS Firewall rule to create in a batch operation.
pub const BatchCreateFirewallRuleInputItem = struct {
    /// The action to take when a DNS query matches the firewall rule.
    action: FirewallRuleAction,

    /// The DNS record type for the custom response when the action is BLOCK.
    block_override_dns_type: ?BlockOverrideDnsQueryType,

    /// The custom domain name for the BLOCK response.
    block_override_domain: ?[]const u8,

    /// The TTL value for the custom response when the action is BLOCK.
    block_override_ttl: ?i32,

    /// The type of block response to return when the action is BLOCK.
    block_response: ?FirewallBlockResponse,

    /// A unique string that identifies the request and ensures idempotency.
    client_token: []const u8,

    /// The confidence threshold for advanced threat detection.
    confidence_threshold: ?ConfidenceThreshold,

    /// A description of the firewall rule.
    description: ?[]const u8,

    /// Whether to enable advanced DNS threat protection for the firewall rule.
    dns_advanced_protection: ?DnsAdvancedProtection,

    /// The ID of the DNS view to associate the firewall rule with.
    dns_view_id: []const u8,

    /// The ID of the firewall domain list to associate with the rule.
    firewall_domain_list_id: ?[]const u8,

    /// A name for the firewall rule.
    name: []const u8,

    /// The priority of the firewall rule.
    priority: ?i64,

    /// The DNS query type that the firewall rule should match.
    q_type: ?[]const u8,

    pub const json_field_names = .{
        .action = "action",
        .block_override_dns_type = "blockOverrideDnsType",
        .block_override_domain = "blockOverrideDomain",
        .block_override_ttl = "blockOverrideTtl",
        .block_response = "blockResponse",
        .client_token = "clientToken",
        .confidence_threshold = "confidenceThreshold",
        .description = "description",
        .dns_advanced_protection = "dnsAdvancedProtection",
        .dns_view_id = "dnsViewId",
        .firewall_domain_list_id = "firewallDomainListId",
        .name = "name",
        .priority = "priority",
        .q_type = "qType",
    };
};
