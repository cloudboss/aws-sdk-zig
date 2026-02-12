const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoPlacement = @import("auto_placement.zig").AutoPlacement;
const HostMaintenance = @import("host_maintenance.zig").HostMaintenance;
const HostRecovery = @import("host_recovery.zig").HostRecovery;
const UnsuccessfulItem = @import("unsuccessful_item.zig").UnsuccessfulItem;
const serde = @import("serde.zig");

/// Modify the auto-placement setting of a Dedicated Host. When auto-placement
/// is enabled,
/// any instances that you launch with a tenancy of `host` but without a
/// specific
/// host ID are placed onto any available Dedicated Host in your account that
/// has
/// auto-placement enabled. When auto-placement is disabled, you need to provide
/// a host ID
/// to have the instance launch onto a specific host. If no host ID is provided,
/// the
/// instance is launched onto a suitable host with auto-placement enabled.
///
/// You can also use this API action to modify a Dedicated Host to support
/// either multiple
/// instance types in an instance family, or to support a specific instance type
/// only.
pub const ModifyHostsInput = struct {
    /// Specify whether to enable or disable auto-placement.
    auto_placement: ?AutoPlacement = null,

    /// The IDs of the Dedicated Hosts to modify.
    host_ids: []const []const u8,

    /// Indicates whether to enable or disable host maintenance for the Dedicated
    /// Host. For
    /// more information, see [Host
    /// maintenance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-maintenance.html) in the *Amazon EC2 User Guide*.
    host_maintenance: ?HostMaintenance = null,

    /// Indicates whether to enable or disable host recovery for the Dedicated Host.
    /// For more
    /// information, see [Host
    /// recovery](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-recovery.html) in
    /// the *Amazon EC2 User Guide*.
    host_recovery: ?HostRecovery = null,

    /// Specifies the instance family to be supported by the Dedicated Host. Specify
    /// this
    /// parameter to modify a Dedicated Host to support multiple instance types
    /// within its
    /// current instance family.
    ///
    /// If you want to modify a Dedicated Host to support a specific instance type
    /// only, omit
    /// this parameter and specify **InstanceType** instead. You
    /// cannot specify **InstanceFamily** and **InstanceType** in the same request.
    instance_family: ?[]const u8 = null,

    /// Specifies the instance type to be supported by the Dedicated Host. Specify
    /// this
    /// parameter to modify a Dedicated Host to support only a specific instance
    /// type.
    ///
    /// If you want to modify a Dedicated Host to support multiple instance types in
    /// its
    /// current instance family, omit this parameter and specify **InstanceFamily**
    /// instead. You cannot specify **InstanceType** and **InstanceFamily** in the
    /// same request.
    instance_type: ?[]const u8 = null,
};

pub const ModifyHostsOutput = struct {
    /// The IDs of the Dedicated Hosts that were successfully modified.
    successful: ?[]const []const u8 = null,

    /// The IDs of the Dedicated Hosts that could not be modified. Check whether the
    /// setting
    /// you requested can be used.
    unsuccessful: ?[]const UnsuccessfulItem = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyHostsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyHostsInput, options: Options) !ModifyHostsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyHostsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyHosts&Version=2016-11-15");
    if (input.auto_placement) |v| {
        try body_buf.appendSlice(alloc, "&AutoPlacement=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    for (input.host_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&HostIds.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.host_maintenance) |v| {
        try body_buf.appendSlice(alloc, "&HostMaintenance=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.host_recovery) |v| {
        try body_buf.appendSlice(alloc, "&HostRecovery=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.instance_family) |v| {
        try body_buf.appendSlice(alloc, "&InstanceFamily=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.instance_type) |v| {
        try body_buf.appendSlice(alloc, "&InstanceType=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyHostsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyHostsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "successful")) {
                    result.successful = try serde.deserializeResponseHostIdList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "unsuccessful")) {
                    result.unsuccessful = try serde.deserializeUnsuccessfulItemList(&reader, alloc, "item");
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
