const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MaintenanceDetails = @import("maintenance_details.zig").MaintenanceDetails;
const serde = @import("serde.zig");

pub const GetVpnTunnelReplacementStatusInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the Site-to-Site VPN connection.
    vpn_connection_id: []const u8,

    /// The external IP address of the VPN tunnel.
    vpn_tunnel_outside_ip_address: []const u8,
};

pub const GetVpnTunnelReplacementStatusOutput = struct {
    /// The ID of the customer gateway.
    customer_gateway_id: ?[]const u8 = null,

    /// Get details of pending tunnel endpoint maintenance.
    maintenance_details: ?MaintenanceDetails = null,

    /// The ID of the transit gateway associated with the VPN connection.
    transit_gateway_id: ?[]const u8 = null,

    /// The ID of the Site-to-Site VPN connection.
    vpn_connection_id: ?[]const u8 = null,

    /// The ID of the virtual private gateway.
    vpn_gateway_id: ?[]const u8 = null,

    /// The external IP address of the VPN tunnel.
    vpn_tunnel_outside_ip_address: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVpnTunnelReplacementStatusInput, options: CallOptions) !GetVpnTunnelReplacementStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVpnTunnelReplacementStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetVpnTunnelReplacementStatus&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&VpnConnectionId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpn_connection_id);
    try body_buf.appendSlice(allocator, "&VpnTunnelOutsideIpAddress=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpn_tunnel_outside_ip_address);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVpnTunnelReplacementStatusOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetVpnTunnelReplacementStatusOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "customerGatewayId")) {
                    result.customer_gateway_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "maintenanceDetails")) {
                    result.maintenance_details = try serde.deserializeMaintenanceDetails(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "transitGatewayId")) {
                    result.transit_gateway_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "vpnConnectionId")) {
                    result.vpn_connection_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "vpnGatewayId")) {
                    result.vpn_gateway_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "vpnTunnelOutsideIpAddress")) {
                    result.vpn_tunnel_outside_ip_address = try allocator.dupe(u8, try reader.readElementText());
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
