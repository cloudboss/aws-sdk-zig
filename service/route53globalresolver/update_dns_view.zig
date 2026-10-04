const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DnsSecValidationType = @import("dns_sec_validation_type.zig").DnsSecValidationType;
const EdnsClientSubnetType = @import("edns_client_subnet_type.zig").EdnsClientSubnetType;
const FirewallRulesFailOpenType = @import("firewall_rules_fail_open_type.zig").FirewallRulesFailOpenType;
const ProfileResourceStatus = @import("profile_resource_status.zig").ProfileResourceStatus;

pub const UpdateDNSViewInput = struct {
    /// A description of the DNS view.
    description: ?[]const u8 = null,

    /// Whether to enable DNSSEC validation for the DNS view.
    dnssec_validation: ?DnsSecValidationType = null,

    /// The unique identifier of the DNS view to update.
    dns_view_id: []const u8,

    /// Whether to enable EDNS Client Subnet injection for the DNS view.
    edns_client_subnet: ?EdnsClientSubnetType = null,

    /// Whether firewall rules should fail open when they cannot be evaluated.
    firewall_rules_fail_open: ?FirewallRulesFailOpenType = null,

    /// The name of the DNS view.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .dnssec_validation = "dnssecValidation",
        .dns_view_id = "dnsViewId",
        .edns_client_subnet = "ednsClientSubnet",
        .firewall_rules_fail_open = "firewallRulesFailOpen",
        .name = "name",
    };
};

pub const UpdateDNSViewOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated DNS view.
    arn: []const u8,

    /// The unique string that identifies the request and ensures idempotency.
    client_token: ?[]const u8 = null,

    /// The date and time when the DNS view was originally created.
    created_at: i64,

    /// The description of the updated DNS view.
    description: ?[]const u8 = null,

    /// Whether DNSSEC validation is enabled for the updated DNS view.
    dnssec_validation: DnsSecValidationType,

    /// Whether EDNS Client Subnet injection is enabled for the updated DNS view.
    edns_client_subnet: EdnsClientSubnetType,

    /// Whether firewall rules fail open when they cannot be evaluated for the
    /// updated DNS view.
    firewall_rules_fail_open: FirewallRulesFailOpenType,

    /// The ID of the global resolver associated with the updated DNS view.
    global_resolver_id: []const u8,

    /// The unique identifier of the updated DNS view.
    id: []const u8,

    /// The name of the updated DNS view.
    name: []const u8,

    /// The current status of the updated DNS view.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDNSViewInput, options: CallOptions) !UpdateDNSViewOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDNSViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dns-views/");
    try path_buf.appendSlice(allocator, input.dns_view_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dnssec_validation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dnssecValidation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.edns_client_subnet) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ednsClientSubnet\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.firewall_rules_fail_open) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"firewallRulesFailOpen\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDNSViewOutput {
    var result: UpdateDNSViewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDNSViewOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
