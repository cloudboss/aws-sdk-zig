const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNetworkRoutesInput, options: CallOptions) !GetNetworkRoutesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNetworkRoutesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/network-routes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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
