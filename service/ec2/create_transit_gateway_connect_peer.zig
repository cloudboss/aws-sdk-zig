const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TransitGatewayConnectRequestBgpOptions = @import("transit_gateway_connect_request_bgp_options.zig").TransitGatewayConnectRequestBgpOptions;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TransitGatewayConnectPeer = @import("transit_gateway_connect_peer.zig").TransitGatewayConnectPeer;
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateTransitGatewayConnectPeerOutput) void {
        self._arena.deinit();
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateTransitGatewayConnectPeerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateTransitGatewayConnectPeer&Version=2016-11-15");
    if (input.bgp_options) |v| {
        if (v.peer_asn) |sv| {
            try body_buf.appendSlice(alloc, "&BgpOptions.PeerAsn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    for (input.inside_cidr_blocks, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InsideCidrBlocks.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    try body_buf.appendSlice(alloc, "&PeerAddress=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.peer_address);
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.transit_gateway_address) |v| {
        try body_buf.appendSlice(alloc, "&TransitGatewayAddress=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&TransitGatewayAttachmentId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.transit_gateway_attachment_id);

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
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateTransitGatewayConnectPeerOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "transitGatewayConnectPeer")) {
                    result.transit_gateway_connect_peer = try serde.deserializeTransitGatewayConnectPeer(&reader, alloc);
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
