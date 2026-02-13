const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VpnConnection = @import("vpn_connection.zig").VpnConnection;
const serde = @import("serde.zig");

/// Modifies the customer gateway or the target gateway of an Amazon Web
/// Services Site-to-Site VPN connection. To
/// modify the target gateway, the following migration options are available:
///
/// * An existing virtual private gateway to a new virtual private gateway
///
/// * An existing virtual private gateway to a transit gateway
///
/// * An existing transit gateway to a new transit gateway
///
/// * An existing transit gateway to a virtual private gateway
///
/// Before you perform the migration to the new gateway, you must configure the
/// new
/// gateway. Use CreateVpnGateway to create a virtual private gateway, or
/// CreateTransitGateway to create a transit gateway.
///
/// This step is required when you migrate from a virtual private gateway with
/// static
/// routes to a transit gateway.
///
/// You must delete the static routes before you migrate to the new gateway.
///
/// Keep a copy of the static route before you delete it. You will need to add
/// back these
/// routes to the transit gateway after the VPN connection migration is
/// complete.
///
/// After you migrate to the new gateway, you might need to modify your VPC
/// route table.
/// Use CreateRoute and DeleteRoute to make the changes
/// described in [Update VPC route
/// tables](https://docs.aws.amazon.com/vpn/latest/s2svpn/modify-vpn-target.html#step-update-routing) in the *Amazon Web Services Site-to-Site VPN User Guide*.
///
/// When the new gateway is a transit gateway, modify the transit gateway route
/// table to
/// allow traffic between the VPC and the Amazon Web Services Site-to-Site VPN
/// connection.
/// Use CreateTransitGatewayRoute to add the routes.
///
/// If you deleted VPN static routes, you must add the static routes to the
/// transit
/// gateway route table.
///
/// After you perform this operation, the VPN endpoint's IP addresses on the
/// Amazon Web Services side and the tunnel options remain intact. Your Amazon
/// Web Services Site-to-Site VPN connection will
/// be temporarily unavailable for a brief period while we provision the new
/// endpoints.
pub const ModifyVpnConnectionInput = struct {
    /// The ID of the customer gateway at your end of the VPN connection.
    customer_gateway_id: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The ID of the VPN connection.
    vpn_connection_id: []const u8,

    /// The ID of the virtual private gateway at the Amazon Web Services side of the
    /// VPN
    /// connection.
    vpn_gateway_id: ?[]const u8 = null,
};

pub const ModifyVpnConnectionOutput = struct {
    /// Information about the VPN connection.
    vpn_connection: ?VpnConnection = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyVpnConnectionOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVpnConnectionInput, options: Options) !ModifyVpnConnectionOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpnConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpnConnection&Version=2016-11-15");
    if (input.customer_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&CustomerGatewayId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.transit_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&TransitGatewayId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&VpnConnectionId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.vpn_connection_id);
    if (input.vpn_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&VpnGatewayId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVpnConnectionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVpnConnectionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "vpnConnection")) {
                    result.vpn_connection = try serde.deserializeVpnConnection(&reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

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
