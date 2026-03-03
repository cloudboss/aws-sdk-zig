const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RouteTableIdentifier = @import("route_table_identifier.zig").RouteTableIdentifier;
const RouteState = @import("route_state.zig").RouteState;
const RouteType = @import("route_type.zig").RouteType;
const CoreNetworkSegmentEdgeIdentifier = @import("core_network_segment_edge_identifier.zig").CoreNetworkSegmentEdgeIdentifier;
const NetworkRoute = @import("network_route.zig").NetworkRoute;
const RouteTableType = @import("route_table_type.zig").RouteTableType;

pub const GetNetworkRoutesInput = struct {
    /// Filter by route table destination. Possible Values:
    /// TRANSIT_GATEWAY_ATTACHMENT_ID, RESOURCE_ID, or RESOURCE_TYPE.
    destination_filters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// An exact CIDR block.
    exact_cidr_matches: ?[]const []const u8 = null,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The most specific route that matches the traffic (longest prefix match).
    longest_prefix_matches: ?[]const []const u8 = null,

    /// The IDs of the prefix lists.
    prefix_list_ids: ?[]const []const u8 = null,

    /// The ID of the route table.
    route_table_identifier: RouteTableIdentifier,

    /// The route states.
    states: ?[]const RouteState = null,

    /// The routes with a subnet that match the specified CIDR filter.
    subnet_of_matches: ?[]const []const u8 = null,

    /// The routes with a CIDR that encompasses the CIDR filter. Example: If you
    /// specify 10.0.1.0/30, then the result returns 10.0.1.0/29.
    supernet_of_matches: ?[]const []const u8 = null,

    /// The route types.
    types: ?[]const RouteType = null,

    pub const json_field_names = .{
        .destination_filters = "DestinationFilters",
        .exact_cidr_matches = "ExactCidrMatches",
        .global_network_id = "GlobalNetworkId",
        .longest_prefix_matches = "LongestPrefixMatches",
        .prefix_list_ids = "PrefixListIds",
        .route_table_identifier = "RouteTableIdentifier",
        .states = "States",
        .subnet_of_matches = "SubnetOfMatches",
        .supernet_of_matches = "SupernetOfMatches",
        .types = "Types",
    };
};

pub const GetNetworkRoutesOutput = struct {
    /// Describes a core network segment edge.
    core_network_segment_edge: ?CoreNetworkSegmentEdgeIdentifier = null,

    /// The network routes.
    network_routes: ?[]const NetworkRoute = null,

    /// The ARN of the route table.
    route_table_arn: ?[]const u8 = null,

    /// The route table creation time.
    route_table_timestamp: ?i64 = null,

    /// The route table type.
    route_table_type: ?RouteTableType = null,

    pub const json_field_names = .{
        .core_network_segment_edge = "CoreNetworkSegmentEdge",
        .network_routes = "NetworkRoutes",
        .route_table_arn = "RouteTableArn",
        .route_table_timestamp = "RouteTableTimestamp",
        .route_table_type = "RouteTableType",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNetworkRoutesInput, options: Options) !GetNetworkRoutesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "networkmanager");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNetworkRoutesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/network-routes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.destination_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.exact_cidr_matches) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExactCidrMatches\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.longest_prefix_matches) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LongestPrefixMatches\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prefix_list_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PrefixListIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RouteTableIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.route_table_identifier), input.route_table_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.states) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"States\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subnet_of_matches) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SubnetOfMatches\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.supernet_of_matches) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SupernetOfMatches\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Types\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNetworkRoutesOutput {
    var result: GetNetworkRoutesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetNetworkRoutesOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "CoreNetworkPolicyException")) {
        return .{ .arena = arena, .kind = .{ .core_network_policy_exception = .{
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
