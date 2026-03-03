const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const DeleteGlobalResolverInput = struct {
    /// The unique identifier of the Route 53 Global Resolver to delete.
    global_resolver_id: []const u8,

    pub const json_field_names = .{
        .global_resolver_id = "globalResolverId",
    };
};

pub const DeleteGlobalResolverOutput = struct {
    /// The Amazon Resource Name (ARN) of the deleted Route 53 Global Resolver.
    arn: []const u8,

    /// The unique string that identifies the request and ensures idempotency.
    client_token: []const u8,

    /// The date and time when the Route 53 Global Resolver was originally created.
    created_at: i64,

    /// The description of the deleted Route 53 Global Resolver.
    description: ?[]const u8 = null,

    /// The hostname that DNS clients used for TLS certificate validation when
    /// connecting to the deleted Route 53 Global Resolver.
    dns_name: []const u8,

    /// The unique identifier of the deleted Route 53 Global Resolver.
    id: []const u8,

    /// The global anycast IPv4 addresses that were associated with the deleted
    /// Route 53 Global Resolver.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// The name of the deleted Route 53 Global Resolver.
    name: []const u8,

    /// The AWS Region where observability data for the deleted Route 53 Global
    /// Resolver was stored.
    observability_region: ?[]const u8 = null,

    /// The AWS Regions where the deleted Route 53 Global Resolver was deployed and
    /// operational.
    regions: ?[]const []const u8 = null,

    /// The final status of the deleted Route 53 Global Resolver.
    status: CRResourceStatus,

    /// The date and time when the Route 53 Global Resolver was last updated before
    /// deletion.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .dns_name = "dnsName",
        .id = "id",
        .ipv_4_addresses = "ipv4Addresses",
        .name = "name",
        .observability_region = "observabilityRegion",
        .regions = "regions",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteGlobalResolverInput, options: Options) !DeleteGlobalResolverOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteGlobalResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/global-resolver/");
    try path_buf.appendSlice(allocator, input.global_resolver_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .DELETE;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteGlobalResolverOutput {
    var result: DeleteGlobalResolverOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteGlobalResolverOutput, body, allocator);
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
