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

pub const DeleteFirewallRuleInput = struct {
    /// The unique identifier of the firewall rule to delete.
    firewall_rule_id: []const u8,

    pub const json_field_names = .{
        .firewall_rule_id = "firewallRuleId",
    };
};

pub const DeleteFirewallRuleOutput = struct {
    /// The action that was configured for the deleted firewall rule.
    action: FirewallRuleAction,

    /// The DNS record type that was configured for the deleted firewall rule's
    /// custom response.
    block_override_dns_type: ?BlockOverrideDnsQueryType = null,

    /// The custom domain that was configured for the deleted firewall rule's BLOCK
    /// response.
    block_override_domain: ?[]const u8 = null,

    /// The TTL value that was configured for the deleted firewall rule's custom
    /// response.
    block_override_ttl: ?i32 = null,

    /// The block response type that was configured for the deleted firewall rule.
    block_response: ?FirewallBlockResponse = null,

    /// The confidence threshold that was configured for the deleted firewall rule's
    /// advanced threat detection.
    confidence_threshold: ?ConfidenceThreshold = null,

    /// The date and time when the firewall rule was originally created.
    created_at: i64,

    /// The description of the deleted firewall rule.
    description: ?[]const u8 = null,

    /// Whether advanced DNS threat protection was enabled for the deleted firewall
    /// rule.
    dns_advanced_protection: ?DnsAdvancedProtection = null,

    /// The ID of the DNS view that was associated with the deleted firewall rule.
    dns_view_id: []const u8,

    /// The ID of the firewall domain list that was associated with the deleted
    /// firewall rule.
    firewall_domain_list_id: ?[]const u8 = null,

    /// The unique identifier of the deleted firewall rule.
    id: []const u8,

    /// The name of the deleted firewall rule.
    name: []const u8,

    /// The priority that was configured for the deleted firewall rule.
    priority: i64,

    /// The DNS query type that the deleted firewall rule was configured to match.
    query_type: ?[]const u8 = null,

    /// The final status of the deleted firewall rule.
    status: CRResourceStatus,

    /// The date and time when the firewall rule was last updated before deletion.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFirewallRuleInput, options: CallOptions) !DeleteFirewallRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFirewallRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/firewall-rules/");
    try path_buf.appendSlice(allocator, input.firewall_rule_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFirewallRuleOutput {
    var result: DeleteFirewallRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteFirewallRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
