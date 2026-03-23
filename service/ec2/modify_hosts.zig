const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AutoPlacement = @import("auto_placement.zig").AutoPlacement;
const HostMaintenance = @import("host_maintenance.zig").HostMaintenance;
const HostRecovery = @import("host_recovery.zig").HostRecovery;
const UnsuccessfulItem = @import("unsuccessful_item.zig").UnsuccessfulItem;
const serde = @import("serde.zig");

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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyHostsInput, options: CallOptions) !ModifyHostsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyHostsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyHosts&Version=2016-11-15");
    if (input.auto_placement) |v| {
        try body_buf.appendSlice(allocator, "&AutoPlacement=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    for (input.host_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&HostId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    if (input.host_maintenance) |v| {
        try body_buf.appendSlice(allocator, "&HostMaintenance=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.host_recovery) |v| {
        try body_buf.appendSlice(allocator, "&HostRecovery=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.instance_family) |v| {
        try body_buf.appendSlice(allocator, "&InstanceFamily=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.instance_type) |v| {
        try body_buf.appendSlice(allocator, "&InstanceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyHostsOutput {
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
                    result.successful = try serde.deserializeResponseHostIdList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "unsuccessful")) {
                    result.unsuccessful = try serde.deserializeUnsuccessfulItemList(allocator, &reader, "item");
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
