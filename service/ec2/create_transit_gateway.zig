const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TransitGatewayRequestOptions = @import("transit_gateway_request_options.zig").TransitGatewayRequestOptions;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TransitGateway = @import("transit_gateway.zig").TransitGateway;
const serde = @import("serde.zig");

/// Creates a transit gateway.
///
/// You can use a transit gateway to interconnect your virtual private clouds
/// (VPC) and on-premises networks.
/// After the transit gateway enters the `available` state, you can attach your
/// VPCs and VPN
/// connections to the transit gateway.
///
/// To attach your VPCs, use CreateTransitGatewayVpcAttachment.
///
/// To attach a VPN connection, use CreateCustomerGateway to create a customer
/// gateway and specify the ID of the customer gateway and the ID of the transit
/// gateway in a call to
/// CreateVpnConnection.
///
/// When you create a transit gateway, we create a default transit gateway route
/// table and use it as the default association route table
/// and the default propagation route table. You can use
/// CreateTransitGatewayRouteTable to create
/// additional transit gateway route tables. If you disable automatic route
/// propagation, we do not create a default transit gateway route table.
/// You can use EnableTransitGatewayRouteTablePropagation to propagate routes
/// from a resource
/// attachment to a transit gateway route table. If you disable automatic
/// associations, you can use AssociateTransitGatewayRouteTable to associate a
/// resource attachment with a transit gateway route table.
pub const CreateTransitGatewayInput = struct {
    /// A description of the transit gateway.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The transit gateway options.
    options: ?TransitGatewayRequestOptions = null,

    /// The tags to apply to the transit gateway.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateTransitGatewayOutput = struct {
    /// Information about the transit gateway.
    transit_gateway: ?TransitGateway = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateTransitGatewayOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateTransitGatewayInput, options: Options) !CreateTransitGatewayOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateTransitGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateTransitGateway&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.options) |v| {
        if (v.amazon_side_asn) |sv| {
            try body_buf.appendSlice(alloc, "&Options.AmazonSideAsn=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.auto_accept_shared_attachments) |sv| {
            try body_buf.appendSlice(alloc, "&Options.AutoAcceptSharedAttachments=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.default_route_table_association) |sv| {
            try body_buf.appendSlice(alloc, "&Options.DefaultRouteTableAssociation=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.default_route_table_propagation) |sv| {
            try body_buf.appendSlice(alloc, "&Options.DefaultRouteTablePropagation=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.dns_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.DnsSupport=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.multicast_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.MulticastSupport=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.security_group_referencing_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.SecurityGroupReferencingSupport=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.vpn_ecmp_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.VpnEcmpSupport=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateTransitGatewayOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateTransitGatewayOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "transitGateway")) {
                    result.transit_gateway = try serde.deserializeTransitGateway(&reader, alloc);
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
