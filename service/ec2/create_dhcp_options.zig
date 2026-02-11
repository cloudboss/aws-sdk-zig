const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NewDhcpConfiguration = @import("new_dhcp_configuration.zig").NewDhcpConfiguration;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const DhcpOptions = @import("dhcp_options.zig").DhcpOptions;

/// Creates a custom set of DHCP options. After you create a DHCP option set,
/// you associate
/// it with a VPC. After you associate a DHCP option set with a VPC, all
/// existing and newly
/// launched instances in the VPC use this set of DHCP options.
///
/// The following are the individual DHCP options you can specify. For more
/// information, see
/// [DHCP option
/// sets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_DHCP_Options.html)
/// in the *Amazon VPC User Guide*.
///
/// * `domain-name` - If you're using AmazonProvidedDNS in `us-east-1`,
/// specify `ec2.internal`. If you're using AmazonProvidedDNS in any other
/// Region,
/// specify `region.compute.internal`. Otherwise, specify a custom domain name.
/// This value is used to complete unqualified DNS hostnames.
///
/// Some Linux operating systems accept multiple domain names separated by
/// spaces.
/// However, Windows and other Linux operating systems treat the value as a
/// single
/// domain, which results in unexpected behavior. If your DHCP option set is
/// associated with a VPC that has instances running operating systems that
/// treat
/// the value as a single domain, specify only one domain name.
///
/// * `domain-name-servers` - The IP addresses of up to four DNS servers,
/// or AmazonProvidedDNS. To specify multiple domain name servers in a single
/// parameter,
/// separate the IP addresses using commas. To have your instances receive
/// custom DNS
/// hostnames as specified in `domain-name`, you must specify a custom DNS
/// server.
///
/// * `ntp-servers` - The IP addresses of up to eight Network Time Protocol
///   (NTP)
/// servers (four IPv4 addresses and four IPv6 addresses).
///
/// * `netbios-name-servers` - The IP addresses of up to four NetBIOS name
/// servers.
///
/// * `netbios-node-type` - The NetBIOS node type (1, 2, 4, or 8). We recommend
///   that
/// you specify 2. Broadcast and multicast are not supported. For more
/// information about
/// NetBIOS node types, see [RFC 2132](https://www.ietf.org/rfc/rfc2132.txt).
///
/// * `ipv6-address-preferred-lease-time` - A value (in seconds, minutes, hours,
///   or years) for how frequently a running instance with an IPv6 assigned to
///   it goes through DHCPv6 lease renewal.
/// Acceptable values are between 140 and 2147483647 seconds (approximately 68
/// years). If no value is entered, the default lease time is 140 seconds. If
/// you use long-term addressing for EC2 instances, you can increase the lease
/// time and avoid frequent
/// lease renewal requests. Lease renewal typically occurs when half of the
/// lease time has elapsed.
pub const CreateDhcpOptionsInput = struct {
    /// A DHCP configuration option.
    dhcp_configurations: []const NewDhcpConfiguration,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The tags to assign to the DHCP option.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateDhcpOptionsOutput = struct {
    /// A set of DHCP options.
    dhcp_options: ?DhcpOptions = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateDhcpOptionsOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateDhcpOptionsInput, options: Options) !CreateDhcpOptionsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDhcpOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateDhcpOptions&Version=2016-11-15");
    for (input.dhcp_configurations, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DhcpConfigurations.item.{d}.Key=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.key) |v| {
                try appendUrlEncoded(alloc, &body_buf, v);
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDhcpOptionsOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: CreateDhcpOptionsOutput = .{ .allocator = alloc };

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
