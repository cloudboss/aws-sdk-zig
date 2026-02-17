const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ModifyTransitGatewayOptions = @import("modify_transit_gateway_options.zig").ModifyTransitGatewayOptions;
const TransitGateway = @import("transit_gateway.zig").TransitGateway;
const serde = @import("serde.zig");

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

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyTransitGateway&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.options) |v| {
        if (v.add_transit_gateway_cidr_blocks) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.AddTransitGatewayCidrBlocks.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (v.amazon_side_asn) |sv| {
            try body_buf.appendSlice(alloc, "&Options.AmazonSideAsn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.association_default_route_table_id) |sv| {
            try body_buf.appendSlice(alloc, "&Options.AssociationDefaultRouteTableId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.auto_accept_shared_attachments) |sv| {
            try body_buf.appendSlice(alloc, "&Options.AutoAcceptSharedAttachments=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.default_route_table_association) |sv| {
            try body_buf.appendSlice(alloc, "&Options.DefaultRouteTableAssociation=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.default_route_table_propagation) |sv| {
            try body_buf.appendSlice(alloc, "&Options.DefaultRouteTablePropagation=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.dns_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.DnsSupport=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.encryption_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.EncryptionSupport=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.propagation_default_route_table_id) |sv| {
            try body_buf.appendSlice(alloc, "&Options.PropagationDefaultRouteTableId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.remove_transit_gateway_cidr_blocks) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.RemoveTransitGatewayCidrBlocks.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (v.security_group_referencing_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.SecurityGroupReferencingSupport=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.vpn_ecmp_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.VpnEcmpSupport=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    try body_buf.appendSlice(alloc, "&TransitGatewayId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.transit_gateway_id);

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
