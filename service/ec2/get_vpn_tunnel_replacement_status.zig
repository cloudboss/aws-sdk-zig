const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVpnTunnelReplacementStatusInput, options: Options) !GetVpnTunnelReplacementStatusOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetVpnTunnelReplacementStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetVpnTunnelReplacementStatus&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&VpnConnectionId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.vpn_connection_id);
    try body_buf.appendSlice(alloc, "&VpnTunnelOutsideIpAddress=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.vpn_tunnel_outside_ip_address);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetVpnTunnelReplacementStatusOutput {
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
                    result.customer_gateway_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "maintenanceDetails")) {
                    result.maintenance_details = try serde.deserializeMaintenanceDetails(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "transitGatewayId")) {
                    result.transit_gateway_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "vpnConnectionId")) {
                    result.vpn_connection_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "vpnGatewayId")) {
                    result.vpn_gateway_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "vpnTunnelOutsideIpAddress")) {
                    result.vpn_tunnel_outside_ip_address = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
