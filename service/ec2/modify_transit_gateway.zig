const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ModifyTransitGatewayOptions = @import("modify_transit_gateway_options.zig").ModifyTransitGatewayOptions;
const TransitGateway = @import("transit_gateway.zig").TransitGateway;
const serde = @import("serde.zig");

/// Modifies the specified transit gateway. When you modify a transit gateway,
/// the modified options are applied to new transit gateway attachments only.
/// Your existing transit gateway attachments are not modified.
pub const ModifyTransitGatewayInput = struct {
    /// The description for the transit gateway.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The options to modify.
    options: ?ModifyTransitGatewayOptions = null,

    /// The ID of the transit gateway.
    transit_gateway_id: []const u8,
};

pub const ModifyTransitGatewayOutput = struct {
    /// Information about the transit gateway.
    transit_gateway: ?TransitGateway = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyTransitGatewayOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyTransitGatewayInput, options: Options) !ModifyTransitGatewayOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyTransitGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyTransitGateway&Version=2016-11-15");
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
        if (v.association_default_route_table_id) |sv| {
            try body_buf.appendSlice(alloc, "&Options.AssociationDefaultRouteTableId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
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
        if (v.encryption_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.EncryptionSupport=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.propagation_default_route_table_id) |sv| {
            try body_buf.appendSlice(alloc, "&Options.PropagationDefaultRouteTableId=");
            try appendUrlEncoded(alloc, &body_buf, sv);
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
    try body_buf.appendSlice(alloc, "&TransitGatewayId=");
    try appendUrlEncoded(alloc, &body_buf, input.transit_gateway_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyTransitGatewayOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyTransitGatewayOutput = .{};
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
