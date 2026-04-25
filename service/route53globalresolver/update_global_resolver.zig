const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const GlobalResolverIpAddressType = @import("global_resolver_ip_address_type.zig").GlobalResolverIpAddressType;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const UpdateGlobalResolverInput = struct {
    /// The description of the Global Resolver.
    description: ?[]const u8 = null,

    /// The ID of the Global Resolver.
    global_resolver_id: []const u8,

    /// The IP address type for the Global Resolver. Valid values are IPV4 or
    /// DUAL_STACK for both IPv4 and IPv6 support.
    ip_address_type: ?GlobalResolverIpAddressType = null,

    /// The name of the Global Resolver.
    name: ?[]const u8 = null,

    /// The Amazon Web Services Regions in which the users' Global Resolver query
    /// resolution logs will be propagated.
    observability_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .global_resolver_id = "globalResolverId",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .observability_region = "observabilityRegion",
    };
};

pub const UpdateGlobalResolverOutput = struct {
    /// The Amazon Resource Name (ARN) of the Global Resolver.
    arn: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: []const u8,

    /// The time and date the Global Resolverwas created.
    created_at: i64,

    /// Description of the Global Resolver.
    description: ?[]const u8 = null,

    /// The hostname to be used by the customers' DNS clients for certification
    /// validation.
    dns_name: []const u8,

    /// The ID of the Global Resolver.
    id: []const u8,

    /// The IP address type configured for the updated Global Resolver.
    ip_address_type: ?GlobalResolverIpAddressType = null,

    /// List of anycast IPv4 addresses associated with the Global Resolver instance.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// List of anycast IPv6 addresses associated with the updated Global Resolver
    /// instance. This field is only populated when ipAddressType is DUAL_STACK.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// Name of the Global Resolver.
    name: []const u8,

    /// The Amazon Web Services Regions in which the users' Global Resolver query
    /// resolution logs will be propagated.
    observability_region: ?[]const u8 = null,

    /// The Amazon Web Services Regions in which the Global Resolver will operate.
    regions: ?[]const []const u8 = null,

    /// The operational status of the Global Resolver.
    status: CRResourceStatus,

    /// The time and date the Global Resolver was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .dns_name = "dnsName",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .ipv_4_addresses = "ipv4Addresses",
        .ipv_6_addresses = "ipv6Addresses",
        .name = "name",
        .observability_region = "observabilityRegion",
        .regions = "regions",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGlobalResolverInput, options: CallOptions) !UpdateGlobalResolverOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGlobalResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/global-resolver/");
    try path_buf.appendSlice(allocator, input.global_resolver_id);
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
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ipAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.observability_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"observabilityRegion\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGlobalResolverOutput {
    var result: UpdateGlobalResolverOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateGlobalResolverOutput, body, allocator);
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
