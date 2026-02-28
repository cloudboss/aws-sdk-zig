const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const DnsProtocol = @import("dns_protocol.zig").DnsProtocol;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const CreateAccessSourceInput = struct {
    /// The IP address or CIDR range that is allowed to send DNS queries to the
    /// Route 53 Global Resolver.
    cidr: []const u8,

    /// A unique string that identifies the request and ensures idempotency.
    client_token: ?[]const u8 = null,

    /// The ID of the DNS view to associate with this access source.
    dns_view_id: []const u8,

    /// The IP address type for this access source. Valid values are IPv4 and IPv6
    /// (if the Route 53 Global Resolver supports dual-stack).
    ip_address_type: ?IpAddressType = null,

    /// A descriptive name for the access source.
    name: ?[]const u8 = null,

    /// The DNS protocol that is permitted for this access source. Valid values are
    /// Do53 (DNS over port 53), DoT (DNS over TLS), and DoH (DNS over HTTPS).
    protocol: DnsProtocol,

    /// Tags to associate with the access source.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cidr = "cidr",
        .client_token = "clientToken",
        .dns_view_id = "dnsViewId",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .protocol = "protocol",
        .tags = "tags",
    };
};

pub const CreateAccessSourceOutput = struct {
    /// The Amazon Resource Name (ARN) of the access source.
    arn: []const u8,

    /// The IP address or CIDR range that is allowed to send DNS queries to the
    /// Route 53 Global Resolver.
    cidr: []const u8,

    /// The date and time when the access source was created.
    created_at: i64,

    /// The ID of the DNS view associated with this access source.
    dns_view_id: []const u8,

    /// The unique identifier for the access source.
    id: []const u8,

    /// The IP address type for this access source (IPv4 or IPv6).
    ip_address_type: IpAddressType,

    /// The descriptive name of the access source.
    name: ?[]const u8 = null,

    /// The DNS protocol that is permitted for this access source (Do53, DoT, or
    /// DoH).
    protocol: DnsProtocol,

    /// The operational status of the access source.
    status: CRResourceStatus,

    /// The date and time when the access source was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .cidr = "cidr",
        .created_at = "createdAt",
        .dns_view_id = "dnsViewId",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .protocol = "protocol",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessSourceInput, options: Options) !CreateAccessSourceOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAccessSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/access-sources";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"cidr\":");
    try aws.json.writeValue(@TypeOf(input.cidr), input.cidr, alloc, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"dnsViewId\":");
    try aws.json.writeValue(@TypeOf(input.dns_view_id), input.dns_view_id, alloc, &body_buf);
    has_prev = true;
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ipAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"protocol\":");
    try aws.json.writeValue(@TypeOf(input.protocol), input.protocol, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAccessSourceOutput {
    var result: CreateAccessSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAccessSourceOutput, body, alloc);
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
