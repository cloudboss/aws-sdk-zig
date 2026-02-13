const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Creates a static route associated with a VPN connection between an existing
/// virtual
/// private gateway and a VPN customer gateway. The static route allows traffic
/// to be routed
/// from the virtual private gateway to the VPN customer gateway.
///
/// For more information, see [Amazon Web Services Site-to-Site
/// VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) in the
/// *Amazon Web Services Site-to-Site VPN
/// User Guide*.
pub const CreateVpnConnectionRouteInput = struct {
    /// The CIDR block associated with the local subnet of the customer network.
    destination_cidr_block: []const u8,

    /// The ID of the VPN connection.
    vpn_connection_id: []const u8,
};

pub const CreateVpnConnectionRouteOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateVpnConnectionRouteOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateVpnConnectionRouteInput, options: Options) !CreateVpnConnectionRouteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateVpnConnectionRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateVpnConnectionRoute&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&DestinationCidrBlock=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.destination_cidr_block);
    try body_buf.appendSlice(alloc, "&VpnConnectionId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.vpn_connection_id);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateVpnConnectionRouteOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: CreateVpnConnectionRouteOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
