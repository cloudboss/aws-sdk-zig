const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const UnassignIpv6AddressesInput = struct {
    /// The IPv6 addresses to unassign from the network interface.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// The IPv6 prefixes to unassign from the network interface.
    ipv_6_prefixes: ?[]const []const u8 = null,

    /// The ID of the network interface.
    network_interface_id: []const u8,
};

pub const UnassignIpv6AddressesOutput = struct {
    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The IPv6 addresses that have been unassigned from the network interface.
    unassigned_ipv_6_addresses: ?[]const []const u8 = null,

    /// The IPv6 prefixes that have been unassigned from the network interface.
    unassigned_ipv_6_prefixes: ?[]const []const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UnassignIpv6AddressesInput, options: CallOptions) !UnassignIpv6AddressesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UnassignIpv6AddressesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UnassignIpv6Addresses&Version=2016-11-15");
    if (input.ipv_6_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv6Addresses.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UnassignIpv6AddressesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: UnassignIpv6AddressesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "networkInterfaceId")) {
                    result.network_interface_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "unassignedIpv6Addresses")) {
                    result.unassigned_ipv_6_addresses = try serde.deserializeIpv6AddressList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "unassignedIpv6PrefixSet")) {
                    result.unassigned_ipv_6_prefixes = try serde.deserializeIpPrefixList(allocator, &reader, "item");
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
