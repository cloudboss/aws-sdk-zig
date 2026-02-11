const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VpnConnectionOptionsSpecification = @import("vpn_connection_options_specification.zig").VpnConnectionOptionsSpecification;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const VpnConnection = @import("vpn_connection.zig").VpnConnection;

/// Creates a VPN connection between an existing virtual private gateway or
/// transit
/// gateway and a customer gateway. The supported connection type is
/// `ipsec.1`.
///
/// The response includes information that you need to give to your network
/// administrator
/// to configure your customer gateway.
///
/// **Important:**
///
/// We strongly recommend that you use HTTPS when calling this operation because
/// the
/// response contains sensitive cryptographic information for configuring your
/// customer
/// gateway device.
///
/// If you decide to shut down your VPN connection for any reason and later
/// create a new
/// VPN connection, you must reconfigure your customer gateway with the new
/// information
/// returned from this call.
///
/// This is an idempotent operation. If you perform the operation more than
/// once, Amazon
/// EC2 doesn't return an error.
///
/// For more information, see [Amazon Web Services Site-to-Site
/// VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) in the
/// *Amazon Web Services Site-to-Site VPN
/// User Guide*.
pub const CreateVpnConnectionInput = struct {
    /// The ID of the customer gateway.
    customer_gateway_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The options for the VPN connection.
    options: ?VpnConnectionOptionsSpecification = null,

    /// Specifies the storage mode for the pre-shared key (PSK). Valid values are
    /// `Standard`" (stored in the Site-to-Site VPN service) or `SecretsManager`
    /// (stored in Amazon Web Services Secrets Manager).
    pre_shared_key_storage: ?[]const u8 = null,

    /// The tags to apply to the VPN connection.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ID of the transit gateway. If you specify a transit gateway, you cannot
    /// specify a virtual private
    /// gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The type of VPN connection (`ipsec.1`).
    @"type": []const u8,

    /// The ID of the VPN concentrator to associate with the VPN connection.
    vpn_concentrator_id: ?[]const u8 = null,

    /// The ID of the virtual private gateway. If you specify a virtual private
    /// gateway, you
    /// cannot specify a transit gateway.
    vpn_gateway_id: ?[]const u8 = null,
};

pub const CreateVpnConnectionOutput = struct {
    /// Information about the VPN connection.
    vpn_connection: ?VpnConnection = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateVpnConnectionOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateVpnConnectionInput, options: Options) !CreateVpnConnectionOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateVpnConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateVpnConnection&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&CustomerGatewayId=");
    try appendUrlEncoded(alloc, &body_buf, input.customer_gateway_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.options) |v| {
        if (v.enable_acceleration) |sv| {
            try body_buf.appendSlice(alloc, "&Options.EnableAcceleration=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.local_ipv_4_network_cidr) |sv| {
            try body_buf.appendSlice(alloc, "&Options.LocalIpv4NetworkCidr=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.local_ipv_6_network_cidr) |sv| {
            try body_buf.appendSlice(alloc, "&Options.LocalIpv6NetworkCidr=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.outside_ip_address_type) |sv| {
            try body_buf.appendSlice(alloc, "&Options.OutsideIpAddressType=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.remote_ipv_4_network_cidr) |sv| {
            try body_buf.appendSlice(alloc, "&Options.RemoteIpv4NetworkCidr=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.remote_ipv_6_network_cidr) |sv| {
            try body_buf.appendSlice(alloc, "&Options.RemoteIpv6NetworkCidr=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.static_routes_only) |sv| {
            try body_buf.appendSlice(alloc, "&Options.StaticRoutesOnly=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.transport_transit_gateway_attachment_id) |sv| {
            try body_buf.appendSlice(alloc, "&Options.TransportTransitGatewayAttachmentId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.tunnel_bandwidth) |sv| {
            try body_buf.appendSlice(alloc, "&Options.TunnelBandwidth=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.tunnel_inside_ip_version) |sv| {
            try body_buf.appendSlice(alloc, "&Options.TunnelInsideIpVersion=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.pre_shared_key_storage) |v| {
        try body_buf.appendSlice(alloc, "&PreSharedKeyStorage=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }
    if (input.transit_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&TransitGatewayId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&Type=");
    try appendUrlEncoded(alloc, &body_buf, input.@"type");
    if (input.vpn_concentrator_id) |v| {
        try body_buf.appendSlice(alloc, "&VpnConcentratorId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.vpn_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&VpnGatewayId=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateVpnConnectionOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: CreateVpnConnectionOutput = .{ .allocator = alloc };

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
