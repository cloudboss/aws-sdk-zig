const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const serde = @import("serde.zig");

pub const AssignIpv6AddressesInput = struct {
    /// The number of additional IPv6 addresses to assign to the network interface.
    /// The
    /// specified number of IPv6 addresses are assigned in addition to the existing
    /// IPv6
    /// addresses that are already assigned to the network interface. Amazon EC2
    /// automatically
    /// selects the IPv6 addresses from the subnet range. You can't use this option
    /// if
    /// specifying specific IPv6 addresses.
    ipv_6_address_count: ?i32 = null,

    /// The IPv6 addresses to be assigned to the network interface. You can't use
    /// this option
    /// if you're specifying a number of IPv6 addresses.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// The number of IPv6 prefixes that Amazon Web Services automatically assigns
    /// to the
    /// network interface. You cannot use this option if you use the `Ipv6Prefixes`
    /// option.
    ipv_6_prefix_count: ?i32 = null,

    /// One or more IPv6 prefixes assigned to the network interface. You can't use
    /// this option if you use the `Ipv6PrefixCount` option.
    ipv_6_prefixes: ?[]const []const u8 = null,

    /// The ID of the network interface.
    network_interface_id: []const u8,
};

pub const AssignIpv6AddressesOutput = struct {
    /// The new IPv6 addresses assigned to the network interface. Existing IPv6
    /// addresses that
    /// were assigned to the network interface before the request are not included.
    assigned_ipv_6_addresses: ?[]const []const u8 = null,

    /// The IPv6 prefixes that are assigned to the network interface.
    assigned_ipv_6_prefixes: ?[]const []const u8 = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssignIpv6AddressesInput, options: CallOptions) !AssignIpv6AddressesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssignIpv6AddressesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AssignIpv6Addresses&Version=2016-11-15");
    if (input.ipv_6_address_count) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6AddressCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Addresses.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.ipv_6_prefix_count) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6PrefixCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_prefixes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Prefix.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&NetworkInterfaceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.network_interface_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssignIpv6AddressesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AssignIpv6AddressesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "assignedIpv6Addresses")) {
                    result.assigned_ipv_6_addresses = try serde.deserializeIpv6AddressList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "assignedIpv6PrefixSet")) {
                    result.assigned_ipv_6_prefixes = try serde.deserializeIpPrefixList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "networkInterfaceId")) {
                    result.network_interface_id = try allocator.dupe(u8, try reader.readElementText());
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
