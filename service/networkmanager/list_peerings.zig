const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PeeringType = @import("peering_type.zig").PeeringType;
const PeeringState = @import("peering_state.zig").PeeringState;
const Peering = @import("peering.zig").Peering;

pub const ListPeeringsInput = struct {
    /// The ID of a core network.
    core_network_id: ?[]const u8 = null,

    /// Returns a list edge locations for the
    edge_location: ?[]const u8 = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// Returns a list of a peering requests.
    peering_type: ?PeeringType = null,

    /// Returns a list of the peering request states.
    state: ?PeeringState = null,

    pub const json_field_names = .{
        .core_network_id = "CoreNetworkId",
        .edge_location = "EdgeLocation",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .peering_type = "PeeringType",
        .state = "State",
    };
};

pub const ListPeeringsOutput = struct {
    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// Lists the transit gateway peerings for the `ListPeerings` request.
    peerings: ?[]const Peering = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .peerings = "Peerings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPeeringsInput, options: CallOptions) !ListPeeringsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPeeringsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/peerings";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.core_network_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "coreNetworkId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.edge_location) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "edgeLocation=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.peering_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "peeringType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "state=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPeeringsOutput {
    var result: ListPeeringsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPeeringsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
