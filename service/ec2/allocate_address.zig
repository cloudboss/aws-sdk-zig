const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DomainType = @import("domain_type.zig").DomainType;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AllocateAddressInput, options: Options) !AllocateAddressOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: AllocateAddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AllocateAddress&Version=2016-11-15");
    if (input.address) |v| {
        try body_buf.appendSlice(alloc, "&Address=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.customer_owned_ipv_4_pool) |v| {
        try body_buf.appendSlice(alloc, "&CustomerOwnedIpv4Pool=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.domain) |v| {
        try body_buf.appendSlice(alloc, "&Domain=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ipam_pool_id) |v| {
        try body_buf.appendSlice(alloc, "&IpamPoolId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.network_border_group) |v| {
        try body_buf.appendSlice(alloc, "&NetworkBorderGroup=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.public_ipv_4_pool) |v| {
        try body_buf.appendSlice(alloc, "&PublicIpv4Pool=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
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
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AllocateAddressOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "allocationId")) {
                    result.allocation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "carrierIp")) {
                    result.carrier_ip = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "customerOwnedIp")) {
                    result.customer_owned_ip = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "customerOwnedIpv4Pool")) {
                    result.customer_owned_ipv_4_pool = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "domain")) {
                    result.domain = std.meta.stringToEnum(DomainType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "networkBorderGroup")) {
                    result.network_border_group = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "publicIp")) {
                    result.public_ip = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "publicIpv4Pool")) {
                    result.public_ipv_4_pool = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
