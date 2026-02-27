const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FirewallRuleAction = @import("firewall_rule_action.zig").FirewallRuleAction;
const BlockOverrideDnsQueryType = @import("block_override_dns_query_type.zig").BlockOverrideDnsQueryType;
const FirewallBlockResponse = @import("firewall_block_response.zig").FirewallBlockResponse;
const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;
const DnsAdvancedProtection = @import("dns_advanced_protection.zig").DnsAdvancedProtection;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const UpdateFirewallRuleInput = struct {
    /// The action that DNS Firewall should take on a DNS query when it matches one
    /// of the domains in the rule's domain list, or a threat in a DNS Firewall
    /// Advanced rule.
    action: ?FirewallRuleAction = null,

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

    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: []const u8,

    /// The confidence threshold for DNS Firewall Advanced. You must provide this
    /// value when you create a DNS Firewall Advanced rule.
    confidence_threshold: ?ConfidenceThreshold = null,

    /// The description for the Firewall rule.
    description: ?[]const u8 = null,

    /// The type of the DNS Firewall Advanced rule. Valid values are DGA and
    /// DNS_TUNNELING.
    dns_advanced_protection: ?DnsAdvancedProtection = null,

    /// The ID of the DNS Firewall rule.
    firewall_rule_id: []const u8,

    /// The name of the DNS Firewall rule.
    name: ?[]const u8 = null,

    /// The setting that determines the processing order of the rule in the rule
    /// group. DNS Firewall processes the rules in a rule group by order of
    /// priority, starting from the lowest setting.
    priority: ?i64 = null,

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
        .firewall_rule_id = "firewallRuleId",
        .name = "name",
        .priority = "priority",
    };
};

pub const UpdateFirewallRuleOutput = struct {
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

    /// The time and date the Firewall rule was created.
    created_at: i64,

    /// The description of the Firewall rule.
    description: ?[]const u8 = null,

    /// The type of the DNS Firewall Advanced rule. Valid values are DGA and
    /// DNS_TUNNELING.
    dns_advanced_protection: ?DnsAdvancedProtection = null,

    /// The ID of the DNS view the Firewall rule is associated with.
    dns_view_id: []const u8,

    /// The ID of the domain list associated with the Firewall rule.
    firewall_domain_list_id: ?[]const u8 = null,

    /// The ID of the Firewall rule.
    id: []const u8,

    /// The name of the Firewall rule.
    name: []const u8,

    /// The setting that determines the processing order of the rule in the rule
    /// group. DNS Firewall processes the rules in a rule group by order of
    /// priority, starting from the lowest setting.
    priority: i64,

    /// The DNS query type you want the rule to evaluate.
    query_type: ?[]const u8 = null,

    /// The operational status of the firewall rule.
    status: CRResourceStatus,

    /// The time and date the rule was updated.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFirewallRuleInput, options: Options) !UpdateFirewallRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "route53globalresolver");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateFirewallRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/firewall-rules/");
    try path_buf.appendSlice(alloc, input.firewall_rule_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.action) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"action\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.block_override_dns_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"blockOverrideDnsType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.block_override_domain) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"blockOverrideDomain\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.block_override_ttl) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"blockOverrideTtl\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.block_response) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"blockResponse\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, alloc, &body_buf);
    has_prev = true;
    if (input.confidence_threshold) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"confidenceThreshold\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.dns_advanced_protection) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"dnsAdvancedProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.priority) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"priority\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateFirewallRuleOutput {
    var result: UpdateFirewallRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFirewallRuleOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
