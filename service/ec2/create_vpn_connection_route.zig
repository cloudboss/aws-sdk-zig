const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateVpnConnectionRouteInput = struct {
    /// The CIDR block associated with the local subnet of the customer network.
    destination_cidr_block: []const u8,

    /// The ID of the VPN connection.
    vpn_connection_id: []const u8,
};

pub const CreateVpnConnectionRouteOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVpnConnectionRouteInput, options: CallOptions) !CreateVpnConnectionRouteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVpnConnectionRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateVpnConnectionRoute&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&DestinationCidrBlock=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.destination_cidr_block);
    try body_buf.appendSlice(allocator, "&VpnConnectionId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpn_connection_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVpnConnectionRouteOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CreateVpnConnectionRouteOutput = .{};

    return result;
}
