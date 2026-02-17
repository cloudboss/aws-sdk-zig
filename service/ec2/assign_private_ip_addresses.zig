const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Ipv4PrefixSpecification = @import("ipv_4_prefix_specification.zig").Ipv4PrefixSpecification;
const AssignedPrivateIpAddress = @import("assigned_private_ip_address.zig").AssignedPrivateIpAddress;
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *AssignPrivateIpAddressesOutput) void {
        self._arena.deinit();
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: AssignPrivateIpAddressesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AssignPrivateIpAddresses&Version=2016-11-15");
    if (input.allow_reassignment) |v| {
        try body_buf.appendSlice(alloc, "&AllowReassignment=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ipv_4_prefix_count) |v| {
        try body_buf.appendSlice(alloc, "&Ipv4PrefixCount=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.ipv_4_prefixes) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Ipv4Prefixes.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&NetworkInterfaceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.network_interface_id);
    if (input.private_ip_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PrivateIpAddresses.PrivateIpAddress.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.secondary_private_ip_address_count) |v| {
        try body_buf.appendSlice(alloc, "&SecondaryPrivateIpAddressCount=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AssignPrivateIpAddressesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "assignedIpv4PrefixSet")) {
                    result.assigned_ipv_4_prefixes = try serde.deserializeIpv4PrefixesList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "assignedPrivateIpAddressesSet")) {
                    result.assigned_private_ip_addresses = try serde.deserializeAssignedPrivateIpAddressList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "networkInterfaceId")) {
                    result.network_interface_id = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
