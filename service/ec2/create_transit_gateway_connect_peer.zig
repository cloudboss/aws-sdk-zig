const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TransitGatewayConnectRequestBgpOptions = @import("transit_gateway_connect_request_bgp_options.zig").TransitGatewayConnectRequestBgpOptions;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TransitGatewayConnectPeer = @import("transit_gateway_connect_peer.zig").TransitGatewayConnectPeer;

/// Creates a Connect peer for a specified transit gateway Connect attachment
/// between a
/// transit gateway and an appliance.
///
/// The peer address and transit gateway address must be the same IP address
/// family (IPv4 or IPv6).
///
/// For more information, see [Connect
/// peers](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html#tgw-connect-peer)
/// in the *Amazon Web Services Transit Gateways Guide*.
pub const CreateTransitGatewayConnectPeerInput = struct {
    /// The BGP options for the Connect peer.
    bgp_options: ?TransitGatewayConnectRequestBgpOptions = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The range of inside IP addresses that are used for BGP peering. You must
    /// specify a
    /// size /29 IPv4 CIDR block from the `169.254.0.0/16` range. The first address
    /// from the range must be configured on the appliance as the BGP IP address.
    /// You can also
    /// optionally specify a size /125 IPv6 CIDR block from the `fd00::/8`
    /// range.
    inside_cidr_blocks: []const []const u8,

    /// The peer IP address (GRE outer IP address) on the appliance side of the
    /// Connect peer.
    peer_address: []const u8,

    /// The tags to apply to the Connect peer.
    tag_specifications: ?[]const TagSpecification = null,

    /// The peer IP address (GRE outer IP address) on the transit gateway side of
    /// the Connect peer, which must be
    /// specified from a transit gateway CIDR block. If not specified, Amazon
    /// automatically assigns
    /// the first available IP address from the transit gateway CIDR block.
    transit_gateway_address: ?[]const u8 = null,

    /// The ID of the Connect attachment.
    transit_gateway_attachment_id: []const u8,
};

pub const CreateTransitGatewayConnectPeerOutput = struct {
    /// Information about the Connect peer.
    transit_gateway_connect_peer: ?TransitGatewayConnectPeer = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateTransitGatewayConnectPeerOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateTransitGatewayConnectPeerInput, options: Options) !CreateTransitGatewayConnectPeerOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateTransitGatewayConnectPeerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateTransitGatewayConnectPeer&Version=2016-11-15");
    if (input.bgp_options) |v| {
        if (v.peer_asn) |sv| {
            try body_buf.appendSlice(alloc, "&BgpOptions.PeerAsn=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    for (input.inside_cidr_blocks, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InsideCidrBlocks.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
    }
    try body_buf.appendSlice(alloc, "&PeerAddress=");
    try appendUrlEncoded(alloc, &body_buf, input.peer_address);
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
    if (input.transit_gateway_address) |v| {
        try body_buf.appendSlice(alloc, "&TransitGatewayAddress=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&TransitGatewayAttachmentId=");
    try appendUrlEncoded(alloc, &body_buf, input.transit_gateway_attachment_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateTransitGatewayConnectPeerOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: CreateTransitGatewayConnectPeerOutput = .{ .allocator = alloc };

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
