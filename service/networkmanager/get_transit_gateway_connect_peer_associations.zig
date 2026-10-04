const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TransitGatewayConnectPeerAssociation = @import("transit_gateway_connect_peer_association.zig").TransitGatewayConnectPeerAssociation;

pub const GetTransitGatewayConnectPeerAssociationsInput = struct {
    /// The ID of the global network.
    global_network_id: []const u8,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,

    /// One or more transit gateway Connect peer Amazon Resource Names (ARNs).
    transit_gateway_connect_peer_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .global_network_id = "GlobalNetworkId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .transit_gateway_connect_peer_arns = "TransitGatewayConnectPeerArns",
    };
};

pub const GetTransitGatewayConnectPeerAssociationsOutput = struct {
    /// The token to use for the next page of results.
    next_token: ?[]const u8 = null,

    /// Information about the transit gateway Connect peer associations.
    transit_gateway_connect_peer_associations: ?[]const TransitGatewayConnectPeerAssociation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .transit_gateway_connect_peer_associations = "TransitGatewayConnectPeerAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTransitGatewayConnectPeerAssociationsInput, options: CallOptions) !GetTransitGatewayConnectPeerAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTransitGatewayConnectPeerAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/transit-gateway-connect-peer-associations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    if (input.transit_gateway_connect_peer_arns) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "transitGatewayConnectPeerArns=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTransitGatewayConnectPeerAssociationsOutput {
    var result: GetTransitGatewayConnectPeerAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTransitGatewayConnectPeerAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
