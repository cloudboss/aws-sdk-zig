const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Ipv4PrefixSpecification = @import("ipv_4_prefix_specification.zig").Ipv4PrefixSpecification;
const AssignedPrivateIpAddress = @import("assigned_private_ip_address.zig").AssignedPrivateIpAddress;

/// Assigns the specified secondary private IP addresses to the specified
/// network
/// interface.
///
/// You can specify specific secondary IP addresses, or you can specify the
/// number of
/// secondary IP addresses to be automatically assigned from the subnet's CIDR
/// block range.
/// The number of secondary IP addresses that you can assign to an instance
/// varies by
/// instance type. For more information about Elastic IP addresses, see [Elastic
/// IP
/// Addresses](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html) in the *Amazon EC2 User Guide*.
///
/// When you move a secondary private IP address to another network interface,
/// any Elastic
/// IP address that is associated with the IP address is also moved.
///
/// Remapping an IP address is an asynchronous operation. When you move an IP
/// address from
/// one network interface to another, check
/// `network/interfaces/macs/mac/local-ipv4s` in the instance metadata to
/// confirm that the remapping is complete.
///
/// You must specify either the IP addresses or the IP address count in the
/// request.
///
/// You can optionally use Prefix Delegation on the network interface. You must
/// specify
/// either the IPv4 Prefix Delegation prefixes, or the IPv4 Prefix Delegation
/// count. For
/// information, see [ Assigning prefixes to network
/// interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-prefix-eni.html) in the *Amazon EC2 User Guide*.
pub const AssignPrivateIpAddressesInput = struct {
    /// Indicates whether to allow an IP address that is already assigned to another
    /// network
    /// interface or instance to be reassigned to the specified network interface.
    allow_reassignment: ?bool = null,

    /// The number of IPv4 prefixes that Amazon Web Services automatically assigns
    /// to the network interface. You can't use this option if you use the `Ipv4
    /// Prefixes` option.
    ipv_4_prefix_count: ?i32 = null,

    /// One or more IPv4 prefixes assigned to the network interface. You can't use
    /// this option if you use the `Ipv4PrefixCount` option.
    ipv_4_prefixes: ?[]const []const u8 = null,

    /// The ID of the network interface.
    network_interface_id: []const u8,

    /// The IP addresses to be assigned as a secondary private IP address to the
    /// network
    /// interface. You can't specify this parameter when also specifying a number of
    /// secondary
    /// IP addresses.
    ///
    /// If you don't specify an IP address, Amazon EC2 automatically selects an IP
    /// address within
    /// the subnet range.
    private_ip_addresses: ?[]const []const u8 = null,

    /// The number of secondary IP addresses to assign to the network interface. You
    /// can't
    /// specify this parameter when also specifying private IP addresses.
    secondary_private_ip_address_count: ?i32 = null,
};

pub const AssignPrivateIpAddressesOutput = struct {
    /// The IPv4 prefixes that are assigned to the network interface.
    assigned_ipv_4_prefixes: ?[]const Ipv4PrefixSpecification = null,

    /// The private IP addresses assigned to the network interface.
    assigned_private_ip_addresses: ?[]const AssignedPrivateIpAddress = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const AssignPrivateIpAddressesOutput) void {
        if (self.network_interface_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AssignPrivateIpAddressesInput, options: Options) !AssignPrivateIpAddressesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AssignPrivateIpAddressesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AssignPrivateIpAddresses&Version=2016-11-15");
    if (input.allow_reassignment) |v| {
        try body_buf.appendSlice(alloc, "&AllowReassignment=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ipv_4_prefix_count) |v| {
        try body_buf.appendSlice(alloc, "&Ipv4PrefixCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.ipv_4_prefixes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv4Prefixes.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&NetworkInterfaceId=");
    try appendUrlEncoded(alloc, &body_buf, input.network_interface_id);
    if (input.private_ip_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PrivateIpAddresses.PrivateIpAddress.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.secondary_private_ip_address_count) |v| {
        try body_buf.appendSlice(alloc, "&SecondaryPrivateIpAddressCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AssignPrivateIpAddressesOutput {
    _ = status;
    _ = headers;
    var result: AssignPrivateIpAddressesOutput = .{ .allocator = alloc };
    if (findElement(body, "networkInterfaceId")) |content| {
        result.network_interface_id = try alloc.dupe(u8, content);
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
