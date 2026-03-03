const DnsSecValidationType = @import("dns_sec_validation_type.zig").DnsSecValidationType;
const EdnsClientSubnetType = @import("edns_client_subnet_type.zig").EdnsClientSubnetType;
const FirewallRulesFailOpenType = @import("firewall_rules_fail_open_type.zig").FirewallRulesFailOpenType;
const ProfileResourceStatus = @import("profile_resource_status.zig").ProfileResourceStatus;

/// Summary information about a DNS view.
pub const DNSViewSummary = struct {
    /// The Amazon Resource Name (ARN) of the DNS view.
    arn: []const u8,

    /// The unique string that identifies the request and ensures idempotency.
    client_token: []const u8,

    /// The date and time when the DNS view was created.
    created_at: i64,

    /// A description of the DNS view.
    description: ?[]const u8 = null,

    /// Whether DNSSEC validation is enabled for the DNS view.
    dnssec_validation: DnsSecValidationType,

    /// Whether EDNS Client Subnet injection is enabled for the DNS view.
    edns_client_subnet: EdnsClientSubnetType,

    /// Whether firewall rules fail open when they cannot be evaluated.
    firewall_rules_fail_open: FirewallRulesFailOpenType,

    /// The ID of the global resolver that the DNS view is associated with.
    global_resolver_id: []const u8,

    /// The unique identifier of the DNS view.
    id: []const u8,

    /// The name of the DNS view.
    name: []const u8,

    /// The current status of the DNS view.
    status: ProfileResourceStatus,

    /// The date and time when the DNS view was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .dnssec_validation = "dnssecValidation",
        .edns_client_subnet = "ednsClientSubnet",
        .firewall_rules_fail_open = "firewallRulesFailOpen",
        .global_resolver_id = "globalResolverId",
        .id = "id",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
