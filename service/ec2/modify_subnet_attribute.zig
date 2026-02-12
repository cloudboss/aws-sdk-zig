const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeBooleanValue = @import("attribute_boolean_value.zig").AttributeBooleanValue;
const HostnameType = @import("hostname_type.zig").HostnameType;
const serde = @import("serde.zig");

/// Modifies a subnet attribute. You can only modify one attribute at a time.
///
/// Use this action to modify subnets on Amazon Web Services Outposts.
///
/// * To modify a subnet on an Outpost rack, set both
/// `MapCustomerOwnedIpOnLaunch` and
/// `CustomerOwnedIpv4Pool`. These two parameters act as a single
/// attribute.
///
/// * To modify a subnet on an Outpost server, set either
/// `EnableLniAtDeviceIndex` or
/// `DisableLniAtDeviceIndex`.
///
/// For more information about Amazon Web Services Outposts, see the following:
///
/// * [Outpost
///   servers](https://docs.aws.amazon.com/outposts/latest/userguide/how-servers-work.html)
///
/// * [Outpost
///   racks](https://docs.aws.amazon.com/outposts/latest/userguide/how-racks-work.html)
pub const ModifySubnetAttributeInput = struct {
    /// Specify `true` to indicate that network interfaces created in the
    /// specified subnet should be assigned an IPv6 address. This includes a network
    /// interface
    /// that's created when launching an instance into the subnet (the instance
    /// therefore
    /// receives an IPv6 address).
    ///
    /// If you enable the IPv6 addressing feature for your subnet, your network
    /// interface
    /// or instance only receives an IPv6 address if it's created using version
    /// `2016-11-15` or later of the Amazon EC2 API.
    assign_ipv_6_address_on_creation: ?AttributeBooleanValue = null,

    /// The customer-owned IPv4 address pool associated with the subnet.
    ///
    /// You must set this value when you specify `true` for
    /// `MapCustomerOwnedIpOnLaunch`.
    customer_owned_ipv_4_pool: ?[]const u8 = null,

    /// Specify `true` to indicate that local network interfaces at the current
    /// position should be disabled.
    disable_lni_at_device_index: ?AttributeBooleanValue = null,

    /// Indicates whether DNS queries made to the Amazon-provided DNS Resolver in
    /// this subnet
    /// should return synthetic IPv6 addresses for IPv4-only destinations.
    ///
    /// You must first configure a NAT gateway in a public subnet (separate from the
    /// subnet
    /// containing the IPv6-only workloads). For example, the subnet containing the
    /// NAT gateway
    /// should have a `0.0.0.0/0` route pointing to the internet gateway. For more
    /// information, see [Configure DNS64 and
    /// NAT64](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-nat64-dns64.html#nat-gateway-nat64-dns64-walkthrough) in the *Amazon VPC User Guide*.
    enable_dns_64: ?AttributeBooleanValue = null,

    /// Indicates the device position for local network interfaces in this subnet.
    /// For example,
    /// `1` indicates local network interfaces in this subnet are the secondary
    /// network interface (eth1). A local network interface cannot be the primary
    /// network
    /// interface (eth0).
    enable_lni_at_device_index: ?i32 = null,

    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// AAAA records.
    enable_resource_name_dns_aaaa_record_on_launch: ?AttributeBooleanValue = null,

    /// Indicates whether to respond to DNS queries for instance hostnames with DNS
    /// A records.
    enable_resource_name_dns_a_record_on_launch: ?AttributeBooleanValue = null,

    /// Specify `true` to indicate that network interfaces attached to instances
    /// created in the
    /// specified subnet should be assigned a customer-owned IPv4 address.
    ///
    /// When this value is `true`, you must specify the customer-owned IP pool using
    /// `CustomerOwnedIpv4Pool`.
    map_customer_owned_ip_on_launch: ?AttributeBooleanValue = null,

    /// Specify `true` to indicate that network interfaces attached to instances
    /// created in the
    /// specified subnet should be assigned a public IPv4 address.
    ///
    /// Amazon Web Services charges for all public IPv4 addresses, including public
    /// IPv4 addresses
    /// associated with running instances and Elastic IP addresses. For more
    /// information, see the *Public IPv4 Address* tab on the [Amazon VPC pricing
    /// page](http://aws.amazon.com/vpc/pricing/).
    map_public_ip_on_launch: ?AttributeBooleanValue = null,

    /// The type of hostname to assign to instances in the subnet at launch. For
    /// IPv4-only and dual-stack (IPv4 and IPv6) subnets, an
    /// instance DNS name can be based on the instance IPv4 address (ip-name) or the
    /// instance ID (resource-name). For IPv6 only subnets, an instance
    /// DNS name must be based on the instance ID (resource-name).
    private_dns_hostname_type_on_launch: ?HostnameType = null,

    /// The ID of the subnet.
    subnet_id: []const u8,
};

pub const ModifySubnetAttributeOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifySubnetAttributeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifySubnetAttributeInput, options: Options) !ModifySubnetAttributeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifySubnetAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifySubnetAttribute&Version=2016-11-15");
    if (input.assign_ipv_6_address_on_creation) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&AssignIpv6AddressOnCreation.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.customer_owned_ipv_4_pool) |v| {
        try body_buf.appendSlice(alloc, "&CustomerOwnedIpv4Pool=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.disable_lni_at_device_index) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&DisableLniAtDeviceIndex.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_dns_64) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnableDns64.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_lni_at_device_index) |v| {
        try body_buf.appendSlice(alloc, "&EnableLniAtDeviceIndex=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.enable_resource_name_dns_aaaa_record_on_launch) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnableResourceNameDnsAAAARecordOnLaunch.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.enable_resource_name_dns_a_record_on_launch) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&EnableResourceNameDnsARecordOnLaunch.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.map_customer_owned_ip_on_launch) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&MapCustomerOwnedIpOnLaunch.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.map_public_ip_on_launch) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&MapPublicIpOnLaunch.Value=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.private_dns_hostname_type_on_launch) |v| {
        try body_buf.appendSlice(alloc, "&PrivateDnsHostnameTypeOnLaunch=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&SubnetId=");
    try appendUrlEncoded(alloc, &body_buf, input.subnet_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifySubnetAttributeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: ModifySubnetAttributeOutput = .{};

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
