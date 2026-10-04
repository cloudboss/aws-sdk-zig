const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallRuleAction = @import("firewall_rule_action.zig").FirewallRuleAction;
const BlockOverrideDnsQueryType = @import("block_override_dns_query_type.zig").BlockOverrideDnsQueryType;
const FirewallBlockResponse = @import("firewall_block_response.zig").FirewallBlockResponse;
const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;
const DnsAdvancedProtection = @import("dns_advanced_protection.zig").DnsAdvancedProtection;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const GetFirewallRuleInput = struct {
    /// ID of the DNS Firewall rule.
    firewall_rule_id: []const u8,

    pub const json_field_names = .{
        .firewall_rule_id = "firewallRuleId",
    };
};

pub const GetFirewallRuleOutput = struct {
    /// The action that DNS Firewall should take on a DNS query when it matches one
    /// of the domains in the rule's domain list, or a threat in a DNS Firewall
    /// Advanced rule.
    action: FirewallRuleAction,

    /// The DNS record's type. This determines the format of the record value that
    /// you provided in `BlockOverrideDomain`. Used for the rule action `BLOCK` with
    /// a `BlockResponse` setting of `OVERRIDE`.
    block_override_dns_type: ?BlockOverrideDnsQueryType = null,

    /// The custom DNS record to send back in response to the query. Used for the
    /// rule action `BLOCK` with a `BlockResponse` setting of `OVERRIDE`.
    block_override_domain: ?[]const u8 = null,

    /// The recommended amount of time, in seconds, for the DNS resolver or web
    /// browser to cache the provided override record. Used for the rule action
    /// `BLOCK` with a `BlockResponse` setting of `OVERRIDE`.
    block_override_ttl: ?i32 = null,

    /// The way that you want DNS Firewall to block the request. Used for the rule
    /// action setting `BLOCK`.
    block_response: ?FirewallBlockResponse = null,

    /// The confidence threshold for DNS Firewall Advanced. You must provide this
    /// value when you create a DNS Firewall Advanced rule.
    confidence_threshold: ?ConfidenceThreshold = null,

    /// The time and date the DNS Firewall rule was created.
    created_at: i64,

    /// The description of the DNS Firewall rule.
    description: ?[]const u8 = null,

    /// The type of the DNS Firewall Advanced rule. Valid values are DGA,
    /// DNS_TUNNELING, and DICTIONARY_DGA.
    dns_advanced_protection: ?DnsAdvancedProtection = null,

    /// The DNS view ID the DNS Firewall is associated with.
    dns_view_id: []const u8,

    /// The ID of a DNS Firewall domain list.
    firewall_domain_list_id: ?[]const u8 = null,

    /// ID of the DNS Firewall rule.
    id: []const u8,

    /// The name of the DNS Firewall rule.
    name: []const u8,

    /// The setting that determines the processing order of the rule in the rule
    /// group. DNS Firewall processes the rules in a rule group by order of
    /// priority, starting from the lowest setting.
    priority: i64,

    /// The DNS query type you want the rule to evaluate.
    query_type: ?[]const u8 = null,

    /// The operational status of the DNS Firewall rule.
    status: CRResourceStatus,

    /// The date and time the DNS Firewall rule was updated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFirewallRuleInput, options: CallOptions) !GetFirewallRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53globalresolver", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetFirewallRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/firewall-rules/");
    try path_buf.appendSlice(allocator, input.firewall_rule_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFirewallRuleOutput {
    var result: GetFirewallRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFirewallRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
