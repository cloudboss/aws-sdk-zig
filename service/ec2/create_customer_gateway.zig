const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const GatewayType = @import("gateway_type.zig").GatewayType;
const CustomerGateway = @import("customer_gateway.zig").CustomerGateway;
const serde = @import("serde.zig");

pub const CreateCustomerGatewayInput = struct {
    /// For customer gateway devices that support BGP, specify the device's ASN. You
    /// must specify either `BgpAsn` or `BgpAsnExtended` when creating the customer
    /// gateway. If the ASN is larger than `2,147,483,647`, you must use
    /// `BgpAsnExtended`.
    ///
    /// Default: 65000
    ///
    /// Valid values: `1` to `2,147,483,647`
    bgp_asn: ?i32 = null,

    /// For customer gateway devices that support BGP, specify the device's ASN. You
    /// must specify either `BgpAsn` or `BgpAsnExtended` when creating the customer
    /// gateway. If the ASN is larger than `2,147,483,647`, you must use
    /// `BgpAsnExtended`.
    ///
    /// Valid values: `2,147,483,648` to `4,294,967,295`
    bgp_asn_extended: ?i64 = null,

    /// The Amazon Resource Name (ARN) for the customer gateway certificate.
    certificate_arn: ?[]const u8 = null,

    /// A name for the customer gateway device.
    ///
    /// Length Constraints: Up to 255 characters.
    device_name: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IP address for the customer gateway device's outside interface. The
    /// address must be
    /// static. If `OutsideIpAddressType` in your VPN connection options is set to
    /// `PrivateIpv4`, you can use an RFC6598 or RFC1918 private IPv4 address. If
    /// `OutsideIpAddressType` is set to `Ipv6`, you can use an IPv6 address.
    ip_address: ?[]const u8 = null,

    /// *This member has been deprecated.* The Internet-routable IP address for the
    /// customer gateway's outside interface. The
    /// address must be static.
    public_ip: ?[]const u8 = null,

    /// The tags to apply to the customer gateway.
    tag_specifications: ?[]const TagSpecification = null,

    /// The type of VPN connection that this customer gateway supports
    /// (`ipsec.1`).
    @"type": GatewayType,
};

pub const CreateCustomerGatewayOutput = struct {
    /// Information about the customer gateway.
    customer_gateway: ?CustomerGateway = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomerGatewayInput, options: Options) !CreateCustomerGatewayOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomerGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateCustomerGateway&Version=2016-11-15");
    if (input.bgp_asn) |v| {
        try body_buf.appendSlice(allocator, "&BgpAsn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.bgp_asn_extended) |v| {
        try body_buf.appendSlice(allocator, "&BgpAsnExtended=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.certificate_arn) |v| {
        try body_buf.appendSlice(allocator, "&CertificateArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.device_name) |v| {
        try body_buf.appendSlice(allocator, "&DeviceName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.ip_address) |v| {
        try body_buf.appendSlice(allocator, "&IpAddress=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.public_ip) |v| {
        try body_buf.appendSlice(allocator, "&PublicIp=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&Type=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(input.@"type"));

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomerGatewayOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateCustomerGatewayOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "customerGateway")) {
                    result.customer_gateway = try serde.deserializeCustomerGateway(allocator, &reader);
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
