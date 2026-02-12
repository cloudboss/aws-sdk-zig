const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceStateChange = @import("instance_state_change.zig").InstanceStateChange;
const serde = @import("serde.zig");

/// Stops an Amazon EBS-backed instance. You can restart your instance at any
/// time using
/// the
/// [StartInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_StartInstances.html) API. For more information, see [Stop and start Amazon EC2
/// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html) in the *Amazon EC2 User Guide*.
///
/// When you stop or hibernate an instance, we shut it down. By default, this
/// includes a
/// graceful operating system (OS) shutdown. To bypass the graceful shutdown,
/// use the
/// `skipOsShutdown` parameter; however, this might risk data
/// integrity.
///
/// You can use the StopInstances operation together with the `Hibernate`
/// parameter to hibernate an instance if the instance is [enabled for
/// hibernation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enabling-hibernation.html) and meets the [hibernation
/// prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hibernating-prerequisites.html). Stopping an instance doesn't preserve data stored in RAM,
/// while hibernation does. If hibernation fails, a normal shutdown occurs. For
/// more
/// information, see [Hibernate your Amazon EC2
/// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html) in the *Amazon EC2 User Guide*.
///
/// If your instance appears stuck in the `stopping` state, there might be an
/// issue with the underlying host computer. You can use the StopInstances
/// operation
/// together with the Force parameter to force stop your instance. For more
/// information, see
/// [Troubleshoot
/// Amazon EC2 instance stop
/// issues](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesStopping.html) in the
/// *Amazon EC2 User Guide*.
///
/// Stopping and hibernating an instance differs from rebooting or terminating
/// it. For
/// example, a stopped or hibernated instance retains its root volume and any
/// data volumes,
/// unlike terminated instances where these volumes are automatically deleted.
/// For more
/// information about the differences between stopping, hibernating, rebooting,
/// and
/// terminating instances, see [Amazon EC2
/// instance state
/// changes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html) in the *Amazon EC2 User Guide*.
///
/// We don't charge for instance usage or data transfer fees when an instance is
/// stopped.
/// However, the root volume and any data volumes remain and continue to persist
/// your data,
/// and you're charged for volume usage. Every time you start your instance,
/// Amazon EC2 charges a one-minute minimum for instance usage, followed by
/// per-second
/// billing.
///
/// You can't stop or hibernate instance store-backed instances.
pub const StopInstancesInput = struct {
    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Forces the instance to stop. The instance will first attempt a graceful
    /// shutdown,
    /// which includes flushing file system caches and metadata. If the graceful
    /// shutdown fails
    /// to complete within the timeout period, the instance shuts down forcibly
    /// without flushing
    /// the file system caches and metadata.
    ///
    /// After using this option, you must perform file system check and repair
    /// procedures.
    /// This option is not recommended for Windows instances. For more information,
    /// see [Troubleshoot
    /// Amazon EC2 instance stop
    /// issues](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesStopping.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// Default: `false`
    force: ?bool = null,

    /// Hibernates the instance if the instance was enabled for hibernation at
    /// launch. If the
    /// instance cannot hibernate successfully, a normal shutdown occurs. For more
    /// information,
    /// see [Hibernate
    /// your Amazon EC2
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// Default: `false`
    hibernate: ?bool = null,

    /// The IDs of the instances.
    instance_ids: []const []const u8,

    /// Specifies whether to bypass the graceful OS shutdown process when the
    /// instance is
    /// stopped.
    ///
    /// **Important:**
    ///
    /// Bypassing the graceful OS shutdown might result in data loss or corruption
    /// (for
    /// example, memory contents not flushed to disk or loss of in-flight IOs) or
    /// skipped
    /// shutdown scripts.
    ///
    /// Default: `false`
    skip_os_shutdown: ?bool = null,
};

pub const StopInstancesOutput = struct {
    /// Information about the stopped instances.
    stopping_instances: ?[]const InstanceStateChange = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *StopInstancesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: StopInstancesInput, options: Options) !StopInstancesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: StopInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=StopInstances&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.force) |v| {
        try body_buf.appendSlice(alloc, "&Force=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.hibernate) |v| {
        try body_buf.appendSlice(alloc, "&Hibernate=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    for (input.instance_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceIds.InstanceId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.skip_os_shutdown) |v| {
        try body_buf.appendSlice(alloc, "&SkipOsShutdown=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StopInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: StopInstancesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instancesSet")) {
                    result.stopping_instances = try serde.deserializeInstanceStateChangeList(&reader, alloc, "item");
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
