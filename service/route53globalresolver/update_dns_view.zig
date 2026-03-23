const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "route53globalresolver");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDNSViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/dns-views/");
    try path_buf.appendSlice(allocator, input.dns_view_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
