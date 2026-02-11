const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Associates an Elastic IP address, or carrier IP address (for instances that
/// are in
/// subnets in Wavelength Zones) with an instance or a network interface. Before
/// you can use an
/// Elastic IP address, you must allocate it to your account.
///
/// If the Elastic IP address is already
/// associated with a different instance, it is disassociated from that instance
/// and associated
/// with the specified instance. If you associate an Elastic IP address with an
/// instance that has
/// an existing Elastic IP address, the existing address is disassociated from
/// the instance, but
/// remains allocated to your account.
///
/// [Subnets in Wavelength Zones] You can associate an IP address from the
/// telecommunication
/// carrier to the instance or network interface.
///
/// You cannot associate an Elastic IP address with an interface in a different
/// network border group.
///
/// **Important:**
///
/// This is an idempotent operation. If you perform the operation more than
/// once, Amazon EC2
/// doesn't return an error, and you may be charged for each time the Elastic IP
/// address is
/// remapped to the same instance. For more information, see the *Elastic IP
/// Addresses* section of [Amazon EC2
/// Pricing](http://aws.amazon.com/ec2/pricing/).
pub const AssociateAddressInput = struct {
    /// The allocation ID. This is required.
    allocation_id: ?[]const u8 = null,

    /// Reassociation is automatic, but you can specify false to ensure the
    /// operation fails if the Elastic IP address is already associated with another
    /// resource.
    allow_reassociation: ?bool = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the instance. The instance must have exactly one attached network
    /// interface.
    /// You can specify either the instance ID or the network interface ID, but not
    /// both.
    instance_id: ?[]const u8 = null,

    /// The ID of the network interface. If the instance has more than one network
    /// interface, you must specify a network interface ID.
    ///
    /// You can specify either the instance ID or the network interface ID, but not
    /// both.
    network_interface_id: ?[]const u8 = null,

    /// The primary or secondary private IP address to associate with the Elastic IP
    /// address. If no private IP address is specified, the Elastic IP address is
    /// associated with the primary private IP address.
    private_ip_address: ?[]const u8 = null,

    /// Deprecated.
    public_ip: ?[]const u8 = null,
};

pub const AssociateAddressOutput = struct {
    /// The ID that represents the association of the Elastic IP address with an
    /// instance.
    association_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const AssociateAddressOutput) void {
        if (self.association_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AssociateAddressInput, options: Options) !AssociateAddressOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AssociateAddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AssociateAddress&Version=2016-11-15");
    if (input.allocation_id) |v| {
        try body_buf.appendSlice(alloc, "&AllocationId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.allow_reassociation) |v| {
        try body_buf.appendSlice(alloc, "&AllowReassociation=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_id) |v| {
        try body_buf.appendSlice(alloc, "&InstanceId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.network_interface_id) |v| {
        try body_buf.appendSlice(alloc, "&NetworkInterfaceId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.private_ip_address) |v| {
        try body_buf.appendSlice(alloc, "&PrivateIpAddress=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.public_ip) |v| {
        try body_buf.appendSlice(alloc, "&PublicIp=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AssociateAddressOutput {
    _ = status;
    _ = headers;
    var result: AssociateAddressOutput = .{ .allocator = alloc };
    if (findElement(body, "associationId")) |content| {
        result.association_id = try alloc.dupe(u8, content);
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
