const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DomainType = @import("domain_type.zig").DomainType;
const TagSpecification = @import("tag_specification.zig").TagSpecification;

/// Allocates an Elastic IP address to your Amazon Web Services account. After
/// you allocate the Elastic IP address you can associate
/// it with an instance or network interface. After you release an Elastic IP
/// address, it is released to the IP address
/// pool and can be allocated to a different Amazon Web Services account.
///
/// You can allocate an Elastic IP address from one of the following address
/// pools:
///
/// * Amazon's pool of IPv4 addresses
///
/// * Public IPv4 address range that you own and bring to your Amazon Web
///   Services account using
/// [Bring Your Own IP Addresses
/// (BYOIP)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html)
///
/// * An IPv4 IPAM pool with an Amazon-provided or BYOIP public IPv4 address
///   range
///
/// * IPv4 addresses from your on-premises network made available for use with
///   an Outpost
/// using a [customer-owned IP address
/// pool](https://docs.aws.amazon.com/outposts/latest/userguide/routing.html#ip-addressing) (CoIP pool)
///
/// For more information, see [Elastic IP
/// Addresses](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html) in the *Amazon EC2 User Guide*.
///
/// If you release an Elastic IP address, you might be able to recover it. You
/// cannot recover
/// an Elastic IP address that you released after it is allocated to another
/// Amazon Web Services account. To attempt to recover an Elastic IP address
/// that you released, specify
/// it in this operation.
///
/// You can allocate a carrier IP address which is a public IP address from a
/// telecommunication carrier,
/// to a network interface which resides in a subnet in a Wavelength Zone (for
/// example an EC2 instance).
pub const AllocateAddressInput = struct {
    /// The Elastic IP address to recover or an IPv4 address from an address pool.
    address: ?[]const u8 = null,

    /// The ID of a customer-owned address pool. Use this parameter to let Amazon
    /// EC2
    /// select an address from the address pool. Alternatively, specify a specific
    /// address from the address pool.
    customer_owned_ipv_4_pool: ?[]const u8 = null,

    /// The network (`vpc`).
    domain: ?DomainType = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of an IPAM pool which has an Amazon-provided or BYOIP public IPv4
    /// CIDR provisioned to it. For more information, see [Allocate sequential
    /// Elastic IP addresses from an IPAM
    /// pool](https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-eip-pool.html)
    /// in the *Amazon VPC IPAM User Guide*.
    ipam_pool_id: ?[]const u8 = null,

    /// A unique set of Availability Zones, Local Zones, or Wavelength Zones from
    /// which Amazon Web Services
    /// advertises IP addresses. Use this parameter to limit the IP address to this
    /// location. IP
    /// addresses cannot move between network border groups.
    network_border_group: ?[]const u8 = null,

    /// The ID of an address pool that you own. Use this parameter to let Amazon EC2
    /// select an address from the address pool.
    /// To specify a specific address from the address pool, use the `Address`
    /// parameter instead.
    public_ipv_4_pool: ?[]const u8 = null,

    /// The tags to assign to the Elastic IP address.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const AllocateAddressOutput = struct {
    /// The ID that represents the allocation of the Elastic IP address.
    allocation_id: ?[]const u8 = null,

    /// The carrier IP address. Available only for network interfaces that reside
    /// in a subnet in a Wavelength Zone.
    carrier_ip: ?[]const u8 = null,

    /// The customer-owned IP address.
    customer_owned_ip: ?[]const u8 = null,

    /// The ID of the customer-owned address pool.
    customer_owned_ipv_4_pool: ?[]const u8 = null,

    /// The network (`vpc`).
    domain: ?DomainType = null,

    /// The set of Availability Zones, Local Zones, or Wavelength Zones from which
    /// Amazon Web Services advertises
    /// IP addresses.
    network_border_group: ?[]const u8 = null,

    /// The Amazon-owned IP address. Not available when using an address pool that
    /// you own.
    public_ip: ?[]const u8 = null,

    /// The ID of an address pool that you own.
    public_ipv_4_pool: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const AllocateAddressOutput) void {
        if (self.allocation_id) |v| {
            self.allocator.free(v);
        }
        if (self.carrier_ip) |v| {
            self.allocator.free(v);
        }
        if (self.customer_owned_ip) |v| {
            self.allocator.free(v);
        }
        if (self.customer_owned_ipv_4_pool) |v| {
            self.allocator.free(v);
        }
        if (self.network_border_group) |v| {
            self.allocator.free(v);
        }
        if (self.public_ip) |v| {
            self.allocator.free(v);
        }
        if (self.public_ipv_4_pool) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AllocateAddressInput, options: Options) !AllocateAddressOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AllocateAddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AllocateAddress&Version=2016-11-15");
    if (input.address) |v| {
        try body_buf.appendSlice(alloc, "&Address=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.customer_owned_ipv_4_pool) |v| {
        try body_buf.appendSlice(alloc, "&CustomerOwnedIpv4Pool=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.domain) |v| {
        try body_buf.appendSlice(alloc, "&Domain=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ipam_pool_id) |v| {
        try body_buf.appendSlice(alloc, "&IpamPoolId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.network_border_group) |v| {
        try body_buf.appendSlice(alloc, "&NetworkBorderGroup=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.public_ipv_4_pool) |v| {
        try body_buf.appendSlice(alloc, "&PublicIpv4Pool=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AllocateAddressOutput {
    _ = status;
    _ = headers;
    var result: AllocateAddressOutput = .{ .allocator = alloc };
    if (findElement(body, "allocationId")) |content| {
        result.allocation_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "carrierIp")) |content| {
        result.carrier_ip = try alloc.dupe(u8, content);
    }
    if (findElement(body, "customerOwnedIp")) |content| {
        result.customer_owned_ip = try alloc.dupe(u8, content);
    }
    if (findElement(body, "customerOwnedIpv4Pool")) |content| {
        result.customer_owned_ipv_4_pool = try alloc.dupe(u8, content);
    }
    if (findElement(body, "networkBorderGroup")) |content| {
        result.network_border_group = try alloc.dupe(u8, content);
    }
    if (findElement(body, "publicIp")) |content| {
        result.public_ip = try alloc.dupe(u8, content);
    }
    if (findElement(body, "publicIpv4Pool")) |content| {
        result.public_ipv_4_pool = try alloc.dupe(u8, content);
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
