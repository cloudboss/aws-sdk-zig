const FirewallRuleAction = @import("firewall_rule_action.zig").FirewallRuleAction;
const BlockOverrideDnsQueryType = @import("block_override_dns_query_type.zig").BlockOverrideDnsQueryType;
const FirewallBlockResponse = @import("firewall_block_response.zig").FirewallBlockResponse;
const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;
const DnsAdvancedProtection = @import("dns_advanced_protection.zig").DnsAdvancedProtection;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

/// The result of creating a firewall rule in a batch operation.
pub const BatchCreateFirewallRuleResult = struct {
    /// The action configured for the created firewall rule.
    action: FirewallRuleAction,

    /// The DNS record type configured for the created firewall rule's custom
    /// response.
    block_override_dns_type: ?BlockOverrideDnsQueryType,

    /// The custom domain name configured for the created firewall rule's BLOCK
    /// response.
    block_override_domain: ?[]const u8,

    /// The TTL value configured for the created firewall rule's custom response.
    block_override_ttl: ?i32,

    /// The type of block response configured for the created firewall rule.
    block_response: ?FirewallBlockResponse,

    /// The unique string that identified the request and ensured idempotency.
    client_token: []const u8,

    /// The confidence threshold configured for the created firewall rule's advanced
    /// threat detection.
    confidence_threshold: ?ConfidenceThreshold,

    /// The date and time when the firewall rule was created.
    created_at: ?i64,

    /// The description of the created firewall rule.
    description: ?[]const u8,

    /// Whether advanced DNS threat protection is enabled for the created firewall
    /// rule.
    dns_advanced_protection: ?DnsAdvancedProtection,

    /// The ID of the DNS view associated with the created firewall rule.
    dns_view_id: []const u8,

    /// The ID of the firewall domain list associated with the created firewall
    /// rule.
    firewall_domain_list_id: ?[]const u8,

    /// The unique identifier of the created firewall rule.
    id: ?[]const u8,

    /// The name of the managed domain list associated with the created firewall
    /// rule.
    managed_domain_list_name: ?[]const u8,

    /// The name of the created firewall rule.
    name: []const u8,

    /// The priority of the created firewall rule.
    priority: ?i64,

    /// The DNS query type that the created firewall rule matches.
    query_type: ?[]const u8,

    /// The current status of the created firewall rule.
    status: ?CRResourceStatus,

    /// The date and time when the firewall rule was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .action = "action",
        .block_override_dns_type = "blockOverrideDnsType",
        .block_override_domain = "blockOverrideDomain",
        .block_override_ttl = "blockOverrideTtl",
        .block_response = "blockResponse",
        .client_token = "clientToken",
        .confidence_threshold = "confidenceThreshold",
        .created_at = "createdAt",
        .description = "description",
        .dns_advanced_protection = "dnsAdvancedProtection",
        .dns_view_id = "dnsViewId",
        .firewall_domain_list_id = "firewallDomainListId",
        .id = "id",
        .managed_domain_list_name = "managedDomainListName",
        .name = "name",
        .priority = "priority",
        .query_type = "queryType",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
