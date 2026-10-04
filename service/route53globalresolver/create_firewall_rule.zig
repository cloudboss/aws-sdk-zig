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

pub const CreateFirewallRuleInput = struct {
    /// The action that DNS Firewall should take on a DNS query when it matches one
    /// of the domains in the rule's domain list:
    ///
    /// * `ALLOW` - Permit the request to go through.
    /// * `ALERT` - Permit the request and send metrics and logs to CloudWatch.
    /// * `BLOCK` - Disallow the request. This option requires additional details in
    ///   the rule's `BlockResponse`.
    action: FirewallRuleAction,

    /// The DNS record's type. This determines the format of the record value that
    /// you provided in `BlockOverrideDomain`. Used for the rule action `BLOCK` with
    /// a `BlockResponse` setting of `OVERRIDE`.
    ///
    /// This setting is required if the `BlockResponse` setting is `OVERRIDE`.
    block_override_dns_type: ?BlockOverrideDnsQueryType = null,

    /// The custom DNS record to send back in response to the query. Used for the
    /// rule action `BLOCK` with a `BlockResponse` setting of `OVERRIDE`.
    ///
    /// This setting is required if the `BlockResponse` setting is `OVERRIDE`.
    block_override_domain: ?[]const u8 = null,

    /// The recommended amount of time, in seconds, for the DNS resolver or web
    /// browser to cache the provided override record. Used for the rule action
    /// `BLOCK` with a `BlockResponse` setting of `OVERRIDE`.
    ///
    /// This setting is required if the `BlockResponse` setting is `OVERRIDE`.
    block_override_ttl: ?i32 = null,

    /// The response to return when the action is BLOCK. Valid values are NXDOMAIN
    /// (domain does not exist), NODATA (domain exists but no records), or OVERRIDE
    /// (return custom response).
    block_response: ?FirewallBlockResponse = null,

    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: ?[]const u8 = null,

    /// The confidence threshold for advanced threat detection. Valid values are
    /// HIGH, MEDIUM, or LOW, indicating the accuracy level required for threat
    /// detection.
    confidence_threshold: ?ConfidenceThreshold = null,

    /// An optional description for the firewall rule.
    description: ?[]const u8 = null,

    /// Whether to enable advanced DNS threat protection for this rule. Advanced
    /// protection can detect and block DNS tunneling and Domain Generation
    /// Algorithm (DGA) threats.
    dns_advanced_protection: ?DnsAdvancedProtection = null,

    /// The ID of the DNS view to associate with this firewall rule.
    dns_view_id: []const u8,

    /// The ID of the firewall domain list to use in this rule.
    firewall_domain_list_id: ?[]const u8 = null,

    /// A descriptive name for the firewall rule.
    name: []const u8,

    /// The priority of this rule. Rules are evaluated in priority order, with lower
    /// numbers having higher priority. When a DNS query matches multiple rules, the
    /// rule with the highest priority (lowest number) is applied.
    priority: ?i64 = null,

    /// The DNS query type to match for this rule. Examples include A (IPv4
    /// address), AAAA (IPv6 address), MX (mail exchange), or TXT (text record).
    q_type: ?[]const u8 = null,

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

pub const CreateFirewallRuleOutput = struct {
    /// The action that DNS Firewall takes on DNS queries that match this rule.
    action: FirewallRuleAction,

    /// The DNS record type for the custom response when blockResponse is OVERRIDE.
    block_override_dns_type: ?BlockOverrideDnsQueryType = null,

    /// The custom domain to return when the action is BLOCK and blockResponse is
    /// OVERRIDE.
    block_override_domain: ?[]const u8 = null,

    /// The time-to-live (TTL) value for the custom response when blockResponse is
    /// OVERRIDE.
    block_override_ttl: ?i32 = null,

    /// The response to return when the action is BLOCK.
    block_response: ?FirewallBlockResponse = null,

    /// The confidence threshold for advanced threat detection.
    confidence_threshold: ?ConfidenceThreshold = null,

    /// The date and time when the firewall rule was created.
    created_at: i64,

    /// The description of the firewall rule.
    description: ?[]const u8 = null,

    /// Whether advanced DNS threat protection is enabled for this rule.
    dns_advanced_protection: ?DnsAdvancedProtection = null,

    /// The ID of the DNS view associated with this firewall rule.
    dns_view_id: []const u8,

    /// The ID of the firewall domain list used in this rule.
    firewall_domain_list_id: ?[]const u8 = null,

    /// The unique identifier for the firewall rule.
    id: []const u8,

    /// The name of the firewall rule.
    name: []const u8,

    /// The priority of the firewall rule.
    priority: i64,

    /// The DNS query type that this rule matches.
    query_type: ?[]const u8 = null,

    /// The operational status of the firewall rule.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFirewallRuleInput, options: CallOptions) !CreateFirewallRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFirewallRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/firewall-rules";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.block_override_dns_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blockOverrideDnsType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.block_override_domain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blockOverrideDomain\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.block_override_ttl) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blockOverrideTtl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.block_response) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blockResponse\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.confidence_threshold) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"confidenceThreshold\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dns_advanced_protection) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dnsAdvancedProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dnsViewId\":");
    try aws.json.writeValue(@TypeOf(input.dns_view_id), input.dns_view_id, allocator, &body_buf);
    has_prev = true;
    if (input.firewall_domain_list_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"firewallDomainListId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"priority\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.q_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"qType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFirewallRuleOutput {
    const result: CreateFirewallRuleOutput = try aws.json.parseJsonObject(
        CreateFirewallRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
