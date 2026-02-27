const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpPoolUpdateRequest = @import("ip_pool_update_request.zig").IpPoolUpdateRequest;
const RouteUpdateRequest = @import("route_update_request.zig").RouteUpdateRequest;
const IpPool = @import("ip_pool.zig").IpPool;
const Route = @import("route.zig").Route;
const NetworkState = @import("network_state.zig").NetworkState;

pub const UpdateNetworkInput = struct {
    /// Include this parameter only if you want to change the pool of IP addresses
    /// in the network. An array of IpPoolCreateRequests that identify a collection
    /// of IP addresses in this network that you want to reserve for use in
    /// MediaLive Anywhere. MediaLive Anywhere uses these IP addresses for Push
    /// inputs (in both Bridge and NAT networks) and for output destinations (only
    /// in Bridge networks). Each IpPoolUpdateRequest specifies one CIDR block.
    ip_pools: ?[]const IpPoolUpdateRequest = null,

    /// Include this parameter only if you want to change the name of the Network.
    /// Specify a name that is unique in the AWS account. Names are case-sensitive.
    name: ?[]const u8 = null,

    /// The ID of the network
    network_id: []const u8,

    /// Include this parameter only if you want to change or add routes in the
    /// Network. An array of Routes that MediaLive Anywhere needs to know about in
    /// order to route encoding traffic.
    routes: ?[]const RouteUpdateRequest = null,

    pub const json_field_names = .{
        .ip_pools = "IpPools",
        .name = "Name",
        .network_id = "NetworkId",
        .routes = "Routes",
    };
};

pub const UpdateNetworkOutput = struct {
    /// The ARN of this Network. It is automatically assigned when the Network is
    /// created.
    arn: ?[]const u8 = null,

    associated_cluster_ids: ?[]const []const u8 = null,

    /// The ID of the Network. Unique in the AWS account. The ID is the resource-id
    /// portion of the ARN.
    id: ?[]const u8 = null,

    /// An array of IpPools in your organization's network that identify a
    /// collection of IP addresses in this network that are reserved for use in
    /// MediaLive Anywhere. MediaLive Anywhere uses these IP addresses for Push
    /// inputs (in both Bridge and NAT networks) and for output destinations (only
    /// in Bridge networks). Each IpPool specifies one CIDR block.
    ip_pools: ?[]const IpPool = null,

    /// The name that you specified for the Network.
    name: ?[]const u8 = null,

    /// An array of Routes that MediaLive Anywhere needs to know about in order to
    /// route encoding traffic.
    routes: ?[]const Route = null,

    /// The current state of the Network. Only MediaLive Anywhere can change the
    /// state.
    state: ?NetworkState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_cluster_ids = "AssociatedClusterIds",
        .id = "Id",
        .ip_pools = "IpPools",
        .name = "Name",
        .routes = "Routes",
        .state = "State",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNetworkInput, options: Options) !UpdateNetworkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medialive");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateNetworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/prod/networks/");
    try path_buf.appendSlice(alloc, input.network_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.ip_pools) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IpPools\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.routes) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Routes\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateNetworkOutput {
    var result: UpdateNetworkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateNetworkOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GatewayTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .gateway_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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
