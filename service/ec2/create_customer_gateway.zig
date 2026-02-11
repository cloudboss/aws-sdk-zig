const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const GatewayType = @import("gateway_type.zig").GatewayType;
const CustomerGateway = @import("customer_gateway.zig").CustomerGateway;

/// Provides information to Amazon Web Services about your customer gateway
/// device. The
/// customer gateway device is the appliance at your end of the VPN connection.
/// You
/// must provide the IP address of the customer gateway device’s external
/// interface. The IP address must be static and can be behind a device
/// performing network
/// address translation (NAT).
///
/// For devices that use Border Gateway Protocol (BGP), you can also provide the
/// device's
/// BGP Autonomous System Number (ASN). You can use an existing ASN assigned to
/// your network.
/// If you don't have an ASN already, you can use a private ASN. For more
/// information, see
/// [Customer gateway
/// options for your Site-to-Site VPN
/// connection](https://docs.aws.amazon.com/vpn/latest/s2svpn/cgw-options.html)
/// in the *Amazon Web Services Site-to-Site VPN User Guide*.
///
/// To create more than one customer gateway with the same VPN type, IP address,
/// and
/// BGP ASN, specify a unique device name for each customer gateway. An
/// identical request
/// returns information about the existing customer gateway; it doesn't create a
/// new customer
/// gateway.
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateCustomerGatewayOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateCustomerGatewayInput, options: Options) !CreateCustomerGatewayOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateCustomerGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateCustomerGateway&Version=2016-11-15");
    if (input.bgp_asn) |v| {
        try body_buf.appendSlice(alloc, "&BgpAsn=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.bgp_asn_extended) |v| {
        try body_buf.appendSlice(alloc, "&BgpAsnExtended=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.certificate_arn) |v| {
        try body_buf.appendSlice(alloc, "&CertificateArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.device_name) |v| {
        try body_buf.appendSlice(alloc, "&DeviceName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ip_address) |v| {
        try body_buf.appendSlice(alloc, "&IpAddress=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.public_ip) |v| {
        try body_buf.appendSlice(alloc, "&PublicIp=");
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
    try body_buf.appendSlice(alloc, "&Type=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.@"type"));

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateCustomerGatewayOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: CreateCustomerGatewayOutput = .{ .allocator = alloc };

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
