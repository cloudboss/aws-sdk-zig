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
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNetworkInterfaceInput, options: Options) !CreateNetworkInterfaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNetworkInterfaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateNetworkInterface&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.connection_tracking_specification) |v| {
        if (v.tcp_established_timeout) |sv| {
            try body_buf.appendSlice(allocator, "&ConnectionTrackingSpecification.TcpEstablishedTimeout=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.udp_stream_timeout) |sv| {
            try body_buf.appendSlice(allocator, "&ConnectionTrackingSpecification.UdpStreamTimeout=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.udp_timeout) |sv| {
            try body_buf.appendSlice(allocator, "&ConnectionTrackingSpecification.UdpTimeout=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_primary_ipv_6) |v| {
        try body_buf.appendSlice(allocator, "&EnablePrimaryIpv6=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupId.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.interface_type) |v| {
        try body_buf.appendSlice(allocator, "&InterfaceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.ipv_4_prefix_count) |v| {
        try body_buf.appendSlice(allocator, "&Ipv4PrefixCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_4_prefixes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv4Prefix.item.{d}.Ipv4Prefix=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ipv_4_prefix) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.ipv_6_address_count) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6AddressCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Addresses.item.{d}.Ipv6Address=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ipv_6_address) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Addresses.item.{d}.IsPrimaryIpv6=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.is_primary_ipv_6) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
        }
    }
    if (input.ipv_6_prefix_count) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6PrefixCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_prefixes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Prefix.item.{d}.Ipv6Prefix=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ipv_6_prefix) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.operator) |v| {
        if (v.principal) |sv| {
            try body_buf.appendSlice(allocator, "&Operator.Principal=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.private_ip_address) |v| {
        try body_buf.appendSlice(allocator, "&PrivateIpAddress=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.private_ip_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PrivateIpAddresses.item.{d}.Primary=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.primary) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PrivateIpAddresses.item.{d}.PrivateIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.private_ip_address) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.secondary_private_ip_address_count) |v| {
        try body_buf.appendSlice(allocator, "&SecondaryPrivateIpAddressCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&SubnetId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.subnet_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNetworkInterfaceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateNetworkInterfaceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "clientToken")) {
                    result.client_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "networkInterface")) {
                    result.network_interface = try serde.deserializeNetworkInterface(allocator, &reader);
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
