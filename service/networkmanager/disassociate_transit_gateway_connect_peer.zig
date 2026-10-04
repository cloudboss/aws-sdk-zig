const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TransitGatewayConnectPeerAssociation = @import("transit_gateway_connect_peer_association.zig").TransitGatewayConnectPeerAssociation;

pub const DisassociateTransitGatewayConnectPeerInput = struct {
    /// The ID of the global network.
    global_network_id: []const u8,

    /// The Amazon Resource Name (ARN) of the transit gateway Connect peer.
    transit_gateway_connect_peer_arn: []const u8,

    pub const json_field_names = .{
        .global_network_id = "GlobalNetworkId",
        .transit_gateway_connect_peer_arn = "TransitGatewayConnectPeerArn",
    };
};

pub const DisassociateTransitGatewayConnectPeerOutput = struct {
    /// The transit gateway Connect peer association.
    transit_gateway_connect_peer_association: ?TransitGatewayConnectPeerAssociation = null,

    pub const json_field_names = .{
        .transit_gateway_connect_peer_association = "TransitGatewayConnectPeerAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateTransitGatewayConnectPeerInput, options: CallOptions) !DisassociateTransitGatewayConnectPeerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateTransitGatewayConnectPeerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/transit-gateway-connect-peer-associations/");
    try path_buf.appendSlice(allocator, input.transit_gateway_connect_peer_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateTransitGatewayConnectPeerOutput {
    const result: DisassociateTransitGatewayConnectPeerOutput = try aws.json.parseJsonObject(
        DisassociateTransitGatewayConnectPeerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
