const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceAutoRecoveryState = @import("instance_auto_recovery_state.zig").InstanceAutoRecoveryState;
const InstanceRebootMigrationState = @import("instance_reboot_migration_state.zig").InstanceRebootMigrationState;

/// Modifies the recovery behavior of your instance to disable simplified
/// automatic
/// recovery or set the recovery behavior to default. The default configuration
/// will not
/// enable simplified automatic recovery for an unsupported instance type. For
/// more
/// information, see [Simplified automatic
/// recovery](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-recover.html#instance-configuration-recovery).
///
/// Modifies the reboot migration behavior during a user-initiated reboot of an
/// instance
/// that has a pending `system-reboot` event. For more information, see [Enable
/// or disable reboot
/// migration](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/schedevents_actions_reboot.html#reboot-migration).
pub const ModifyInstanceMaintenanceOptionsInput = struct {
    /// Disables the automatic recovery behavior of your instance or sets it to
    /// default.
    auto_recovery: ?InstanceAutoRecoveryState = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the instance.
    instance_id: []const u8,

    /// Specifies whether to attempt reboot migration during a user-initiated reboot
    /// of an
    /// instance that has a scheduled `system-reboot` event:
    ///
    /// * `default` - Amazon EC2 attempts to migrate the instance to
    /// new hardware (reboot migration). If successful, the `system-reboot`
    /// event is cleared. If unsuccessful, an in-place reboot occurs and the event
    /// remains scheduled.
    ///
    /// * `disabled` - Amazon EC2 keeps the instance on the same
    /// hardware (in-place reboot). The `system-reboot` event remains
    /// scheduled.
    ///
    /// This setting only applies to supported instances that have a scheduled
    /// reboot event.
    /// For more information, see [Enable or disable reboot
    /// migration](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/schedevents_actions_reboot.html#reboot-migration) in the
    /// *Amazon EC2 User Guide*.
    reboot_migration: ?InstanceRebootMigrationState = null,
};

pub const ModifyInstanceMaintenanceOptionsOutput = struct {
    /// Provides information on the current automatic recovery behavior of your
    /// instance.
    auto_recovery: ?InstanceAutoRecoveryState = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// Specifies whether to attempt reboot migration during a user-initiated reboot
    /// of an
    /// instance that has a scheduled `system-reboot` event:
    ///
    /// * `default` - Amazon EC2 attempts to migrate the instance to
    /// new hardware (reboot migration). If successful, the `system-reboot`
    /// event is cleared. If unsuccessful, an in-place reboot occurs and the event
    /// remains scheduled.
    ///
    /// * `disabled` - Amazon EC2 keeps the instance on the same
    /// hardware (in-place reboot). The `system-reboot` event remains
    /// scheduled.
    ///
    /// This setting only applies to supported instances that have a scheduled
    /// reboot event.
    /// For more information, see [Enable or disable reboot
    /// migration](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/schedevents_actions_reboot.html#reboot-migration) in the
    /// *Amazon EC2 User Guide*.
    reboot_migration: ?InstanceRebootMigrationState = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyInstanceMaintenanceOptionsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyInstanceMaintenanceOptionsInput, options: Options) !ModifyInstanceMaintenanceOptionsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyInstanceMaintenanceOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyInstanceMaintenanceOptions&Version=2016-11-15");
    if (input.auto_recovery) |v| {
        try body_buf.appendSlice(alloc, "&AutoRecovery=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try appendUrlEncoded(alloc, &body_buf, input.instance_id);
    if (input.reboot_migration) |v| {
        try body_buf.appendSlice(alloc, "&RebootMigration=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyInstanceMaintenanceOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyInstanceMaintenanceOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "autoRecovery")) {
                    result.auto_recovery = std.meta.stringToEnum(InstanceAutoRecoveryState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "instanceId")) {
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "rebootMigration")) {
                    result.reboot_migration = std.meta.stringToEnum(InstanceRebootMigrationState, try reader.readElementText());
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
