const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectionTrackingSpecificationRequest = @import("connection_tracking_specification_request.zig").ConnectionTrackingSpecificationRequest;
const NetworkInterfaceCreationType = @import("network_interface_creation_type.zig").NetworkInterfaceCreationType;
const Ipv4PrefixSpecificationRequest = @import("ipv_4_prefix_specification_request.zig").Ipv4PrefixSpecificationRequest;
const InstanceIpv6Address = @import("instance_ipv_6_address.zig").InstanceIpv6Address;
const Ipv6PrefixSpecificationRequest = @import("ipv_6_prefix_specification_request.zig").Ipv6PrefixSpecificationRequest;
const OperatorRequest = @import("operator_request.zig").OperatorRequest;
const PrivateIpAddressSpecification = @import("private_ip_address_specification.zig").PrivateIpAddressSpecification;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;

/// Creates a network interface in the specified subnet.
///
/// The number of IP addresses you can assign to a network interface varies by
/// instance
/// type.
///
/// For more information about network interfaces, see [Elastic network
/// interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html) in the
/// *Amazon EC2 User Guide*.
pub const CreateNetworkInterfaceInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A connection tracking specification for the network interface.
    connection_tracking_specification: ?ConnectionTrackingSpecificationRequest = null,

    /// A description for the network interface.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// If you’re creating a network interface in a dual-stack or IPv6-only subnet,
    /// you have
    /// the option to assign a primary IPv6 IP address. A primary IPv6 address is an
    /// IPv6 GUA
    /// address associated with an ENI that you have enabled to use a primary IPv6
    /// address. Use
    /// this option if the instance that this ENI will be attached to relies on its
    /// IPv6 address
    /// not changing. Amazon Web Services will automatically assign an IPv6 address
    /// associated
    /// with the ENI attached to your instance to be the primary IPv6 address. Once
    /// you enable
    /// an IPv6 GUA address to be a primary IPv6, you cannot disable it. When you
    /// enable an IPv6
    /// GUA address to be a primary IPv6, the first IPv6 GUA will be made the
    /// primary IPv6
    /// address until the instance is terminated or the network interface is
    /// detached. If you
    /// have multiple IPv6 addresses associated with an ENI attached to your
    /// instance and you
    /// enable a primary IPv6 address, the first IPv6 GUA address associated with
    /// the ENI
    /// becomes the primary IPv6 address.
    enable_primary_ipv_6: ?bool = null,

    /// The IDs of the security groups.
    groups: ?[]const []const u8 = null,

    /// The type of network interface. The default is `interface`.
    ///
    /// If you specify `efa-only`, do not assign any IP addresses to the network
    /// interface. EFA-only network interfaces do not support IP addresses.
    ///
    /// The only supported values are `interface`, `efa`,
    /// `efa-only`, and `trunk`.
    interface_type: ?NetworkInterfaceCreationType = null,

    /// The number of IPv4 prefixes that Amazon Web Services automatically assigns
    /// to the
    /// network interface.
    ///
    /// You can't specify a count of IPv4 prefixes if you've specified one of the
    /// following:
    /// specific IPv4 prefixes, specific private IPv4 addresses, or a count of
    /// private IPv4
    /// addresses.
    ipv_4_prefix_count: ?i32 = null,

    /// The IPv4 prefixes assigned to the network interface.
    ///
    /// You can't specify IPv4 prefixes if you've specified one of the following: a
    /// count of
    /// IPv4 prefixes, specific private IPv4 addresses, or a count of private IPv4
    /// addresses.
    ipv_4_prefixes: ?[]const Ipv4PrefixSpecificationRequest = null,

    /// The number of IPv6 addresses to assign to a network interface. Amazon EC2
    /// automatically selects the IPv6 addresses from the subnet range.
    ///
    /// You can't specify a count of IPv6 addresses using this parameter if you've
    /// specified
    /// one of the following: specific IPv6 addresses, specific IPv6 prefixes, or a
    /// count of
    /// IPv6 prefixes.
    ///
    /// If your subnet has the `AssignIpv6AddressOnCreation` attribute set, you can
    /// override that setting by specifying 0 as the IPv6 address count.
    ipv_6_address_count: ?i32 = null,

    /// The IPv6 addresses from the IPv6 CIDR block range of your subnet.
    ///
    /// You can't specify IPv6 addresses using this parameter if you've specified
    /// one of the
    /// following: a count of IPv6 addresses, specific IPv6 prefixes, or a count of
    /// IPv6
    /// prefixes.
    ipv_6_addresses: ?[]const InstanceIpv6Address = null,

    /// The number of IPv6 prefixes that Amazon Web Services automatically assigns
    /// to the
    /// network interface.
    ///
    /// You can't specify a count of IPv6 prefixes if you've specified one of the
    /// following:
    /// specific IPv6 prefixes, specific IPv6 addresses, or a count of IPv6
    /// addresses.
    ipv_6_prefix_count: ?i32 = null,

    /// The IPv6 prefixes assigned to the network interface.
    ///
    /// You can't specify IPv6 prefixes if you've specified one of the following: a
    /// count of
    /// IPv6 prefixes, specific IPv6 addresses, or a count of IPv6 addresses.
    ipv_6_prefixes: ?[]const Ipv6PrefixSpecificationRequest = null,

    /// Reserved for internal use.
    operator: ?OperatorRequest = null,

    /// The primary private IPv4 address of the network interface. If you don't
    /// specify an
    /// IPv4 address, Amazon EC2 selects one for you from the subnet's IPv4 CIDR
    /// range. If you
    /// specify an IP address, you cannot indicate any IP addresses specified in
    /// `privateIpAddresses` as primary (only one IP address can be designated as
    /// primary).
    private_ip_address: ?[]const u8 = null,

    /// The private IPv4 addresses.
    ///
    /// You can't specify private IPv4 addresses if you've specified one of the
    /// following: a
    /// count of private IPv4 addresses, specific IPv4 prefixes, or a count of IPv4
    /// prefixes.
    private_ip_addresses: ?[]const PrivateIpAddressSpecification = null,

    /// The number of secondary private IPv4 addresses to assign to a network
    /// interface. When
    /// you specify a number of secondary IPv4 addresses, Amazon EC2 selects these
    /// IP addresses
    /// within the subnet's IPv4 CIDR range. You can't specify this option and
    /// specify more than
    /// one private IP address using `privateIpAddresses`.
    ///
    /// You can't specify a count of private IPv4 addresses if you've specified one
    /// of the
    /// following: specific private IPv4 addresses, specific IPv4 prefixes, or a
    /// count of IPv4
    /// prefixes.
    secondary_private_ip_address_count: ?i32 = null,

    /// The ID of the subnet to associate with the network interface.
    subnet_id: []const u8,

    /// The tags to apply to the new network interface.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateNetworkInterfaceOutput = struct {
    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    client_token: ?[]const u8 = null,

    /// Information about the network interface.
    network_interface: ?NetworkInterface = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateNetworkInterfaceOutput) void {
        if (self.client_token) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateNetworkInterfaceInput, options: Options) !CreateNetworkInterfaceOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateNetworkInterfaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateNetworkInterface&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.connection_tracking_specification) |v| {
        if (v.tcp_established_timeout) |sv| {
            try body_buf.appendSlice(alloc, "&ConnectionTrackingSpecification.TcpEstablishedTimeout=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.udp_stream_timeout) |sv| {
            try body_buf.appendSlice(alloc, "&ConnectionTrackingSpecification.UdpStreamTimeout=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.udp_timeout) |sv| {
            try body_buf.appendSlice(alloc, "&ConnectionTrackingSpecification.UdpTimeout=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_primary_ipv_6) |v| {
        try body_buf.appendSlice(alloc, "&EnablePrimaryIpv6=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Groups.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.interface_type) |v| {
        try body_buf.appendSlice(alloc, "&InterfaceType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.ipv_4_prefix_count) |v| {
        try body_buf.appendSlice(alloc, "&Ipv4PrefixCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.ipv_4_prefixes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv4Prefixes.item.{d}.Ipv4Prefix=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_4_prefix) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.ipv_6_address_count) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6AddressCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Addresses.item.{d}.Ipv6Address=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_6_address) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Addresses.item.{d}.IsPrimaryIpv6=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.is_primary_ipv_6) |v| {
                    try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
                }
            }
        }
    }
    if (input.ipv_6_prefix_count) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6PrefixCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_prefixes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Prefixes.item.{d}.Ipv6Prefix=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_6_prefix) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.operator) |v| {
        if (v.principal) |sv| {
            try body_buf.appendSlice(alloc, "&Operator.Principal=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.private_ip_address) |v| {
        try body_buf.appendSlice(alloc, "&PrivateIpAddress=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.private_ip_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PrivateIpAddresses.item.{d}.Primary=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.primary) |v| {
                    try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PrivateIpAddresses.item.{d}.PrivateIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.private_ip_address) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.secondary_private_ip_address_count) |v| {
        try body_buf.appendSlice(alloc, "&SecondaryPrivateIpAddressCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&SubnetId=");
    try appendUrlEncoded(alloc, &body_buf, input.subnet_id);
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateNetworkInterfaceOutput {
    _ = status;
    var result: CreateNetworkInterfaceOutput = .{ .allocator = alloc };
    if (findElement(body, "clientToken")) |content| {
        result.client_token = try alloc.dupe(u8, content);
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
