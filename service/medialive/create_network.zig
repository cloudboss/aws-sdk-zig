const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpPoolCreateRequest = @import("ip_pool_create_request.zig").IpPoolCreateRequest;
const RouteCreateRequest = @import("route_create_request.zig").RouteCreateRequest;
const IpPool = @import("ip_pool.zig").IpPool;
const Route = @import("route.zig").Route;
const NetworkState = @import("network_state.zig").NetworkState;

pub const CreateNetworkInput = struct {
    /// An array of IpPoolCreateRequests that identify a collection of IP addresses
    /// in your network that you want to reserve for use in MediaLive Anywhere.
    /// MediaLiveAnywhere uses these IP addresses for Push inputs (in both Bridge
    /// and NATnetworks) and for output destinations (only in Bridge networks).
    /// EachIpPoolUpdateRequest specifies one CIDR block.
    ip_pools: ?[]const IpPoolCreateRequest = null,

    /// Specify a name that is unique in the AWS account. We recommend that you
    /// assign a name that hints at the type of traffic on the network. Names are
    /// case-sensitive.
    name: ?[]const u8 = null,

    /// An ID that you assign to a create request. This ID ensures idempotency when
    /// creating resources.
    request_id: ?[]const u8 = null,

    /// An array of routes that MediaLive Anywhere needs to know about in order to
    /// route encoding traffic.
    routes: ?[]const RouteCreateRequest = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .ip_pools = "IpPools",
        .name = "Name",
        .request_id = "RequestId",
        .routes = "Routes",
        .tags = "Tags",
    };
};

pub const CreateNetworkOutput = struct {
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

    /// An array of routes that MediaLive Anywhere needs to know about in order to
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNetworkInput, options: CallOptions) !CreateNetworkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNetworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/prod/networks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ip_pools) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IpPools\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.routes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Routes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNetworkOutput {
    const result: CreateNetworkOutput = try aws.json.parseJsonObject(
        CreateNetworkOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
