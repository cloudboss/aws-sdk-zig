const FirewallRuleAction = @import("firewall_rule_action.zig").FirewallRuleAction;
const BlockOverrideDnsQueryType = @import("block_override_dns_query_type.zig").BlockOverrideDnsQueryType;
const FirewallBlockResponse = @import("firewall_block_response.zig").FirewallBlockResponse;
const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;
const DnsAdvancedProtection = @import("dns_advanced_protection.zig").DnsAdvancedProtection;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

/// Summary information about a firewall rule.
pub const FirewallRulesItem = struct {
    /// The action configured for the firewall rule.
    action: FirewallRuleAction,

    /// The DNS record type configured for the firewall rule's custom response.
    block_override_dns_type: ?BlockOverrideDnsQueryType = null,

    /// The custom domain name configured for the firewall rule's BLOCK response.
    block_override_domain: ?[]const u8 = null,

    /// The TTL value configured for the firewall rule's custom response.
    block_override_ttl: ?i32 = null,

    /// The type of block response configured for the firewall rule.
    block_response: ?FirewallBlockResponse = null,

    /// The confidence threshold configured for the firewall rule's advanced threat
    /// detection.
    confidence_threshold: ?ConfidenceThreshold = null,

    /// The date and time when the firewall rule was created.
    created_at: i64,

    /// The description of the firewall rule.
    description: ?[]const u8 = null,

    /// Whether advanced DNS threat protection is enabled for the firewall rule.
    dns_advanced_protection: ?DnsAdvancedProtection = null,

    /// The ID of the DNS view associated with the firewall rule.
    dns_view_id: []const u8,

    /// The ID of the firewall domain list associated with the firewall rule.
    firewall_domain_list_id: ?[]const u8 = null,

    /// The unique identifier of the firewall rule.
    id: []const u8,

    /// The name of the firewall rule.
    name: []const u8,

    /// The priority of the firewall rule.
    priority: i64,

    /// The DNS query type that the firewall rule matches.
    query_type: ?[]const u8 = null,

    /// The current status of the firewall rule.
    status: CRResourceStatus,

    /// The date and time when the firewall rule was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .action = "action",
        .block_override_dns_type = "blockOverrideDnsType",
        .block_override_domain = "blockOverrideDomain",
        .block_override_ttl = "blockOverrideTtl",
        .block_response = "blockResponse",
        .confidence_threshold = "confidenceThreshold",
        .created_at = "createdAt",
        .description = "description",
        .dns_advanced_protection = "dnsAdvancedProtection",
        .dns_view_id = "dnsViewId",
        .firewall_domain_list_id = "firewallDomainListId",
        .id = "id",
        .name = "name",
        .priority = "priority",
        .query_type = "queryType",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
