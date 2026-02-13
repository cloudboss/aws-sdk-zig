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

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateTransitGateway&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.options) |v| {
        if (v.amazon_side_asn) |sv| {
            try body_buf.appendSlice(alloc, "&Options.AmazonSideAsn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
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
        if (v.multicast_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.MulticastSupport=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.security_group_referencing_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.SecurityGroupReferencingSupport=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.transit_gateway_cidr_blocks) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.TransitGatewayCidrBlocks.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (v.vpn_ecmp_support) |sv| {
            try body_buf.appendSlice(alloc, "&Options.VpnEcmpSupport=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
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
