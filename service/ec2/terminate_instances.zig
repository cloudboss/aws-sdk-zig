const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceStateChange = @import("instance_state_change.zig").InstanceStateChange;
const serde = @import("serde.zig");

/// Terminates (deletes) the specified instances. This operation is
/// [idempotent](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html); if you
/// terminate an instance more than once, each call succeeds.
///
/// **Important:**
///
/// **Terminating an instance is permanent and irreversible.**
///
/// After you terminate an instance, you can no longer connect to it, and it
/// can't be recovered.
/// All attached Amazon EBS volumes that are configured to be deleted on
/// termination are also permanently
/// deleted and can't be recovered. All data stored on instance store volumes is
/// permanently lost.
/// For more information, see [
/// How instance termination
/// works](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-ec2-instance-termination-works.html).
///
/// Before you terminate an instance, ensure that you have backed up all data
/// that you need to
/// retain after the termination to persistent storage.
///
/// If you specify multiple instances and the request fails (for example,
/// because of a
/// single incorrect instance ID), none of the instances are terminated.
///
/// If you terminate multiple instances across multiple Availability Zones, and
/// one or
/// more of the specified instances are enabled for termination protection, the
/// request
/// fails with the following results:
///
/// * The specified instances that are in the same Availability Zone as the
/// protected instance are not terminated.
///
/// * The specified instances that are in different Availability Zones, where no
/// other specified instances are protected, are successfully terminated.
///
/// For example, say you have the following instances:
///
/// * Instance A: `us-east-1a`; Not protected
///
/// * Instance B: `us-east-1a`; Not protected
///
/// * Instance C: `us-east-1b`; Protected
///
/// * Instance D: `us-east-1b`; not protected
///
/// If you attempt to terminate all of these instances in the same request, the
/// request
/// reports failure with the following results:
///
/// * Instance A and Instance B are successfully terminated because none of the
/// specified instances in `us-east-1a` are enabled for termination
/// protection.
///
/// * Instance C and Instance D fail to terminate because at least one of the
/// specified instances in `us-east-1b` (Instance C) is enabled for
/// termination protection.
///
/// Terminated instances remain visible after termination (for approximately one
/// hour).
///
/// By default, Amazon EC2 deletes all EBS volumes that were attached when the
/// instance
/// launched. Volumes attached after instance launch continue running.
///
/// By default, the TerminateInstances operation includes a graceful operating
/// system (OS)
/// shutdown. To bypass the graceful shutdown, use the `skipOsShutdown`
/// parameter; however, this might risk data integrity.
///
/// You can stop, start, and terminate EBS-backed instances. You can only
/// terminate
/// instance store-backed instances. What happens to an instance differs if you
/// stop or
/// terminate it. For example, when you stop an instance, the root device and
/// any other
/// devices attached to the instance persist. When you terminate an instance,
/// any attached
/// EBS volumes with the `DeleteOnTermination` block device mapping parameter
/// set
/// to `true` are automatically deleted. For more information about the
/// differences between stopping and terminating instances, see [Amazon EC2
/// instance state
/// changes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html) in the *Amazon EC2 User Guide*.
///
/// When you terminate an instance, we attempt to terminate it forcibly after a
/// short
/// while. If your instance appears stuck in the shutting-down state after a
/// period of time,
/// there might be an issue with the underlying host computer. For more
/// information about
/// terminating and troubleshooting terminating your instances, see [Terminate
/// Amazon EC2 instances](https://docs.aws.amazon.com/) and
/// [Troubleshooting terminating your
/// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesShuttingDown.html) in the
/// *Amazon EC2 User Guide*.
pub const TerminateInstancesInput = struct {
    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Forces the instances to terminate. The instance will first attempt a
    /// graceful
    /// shutdown, which includes flushing file system caches and metadata. If the
    /// graceful
    /// shutdown fails to complete within the timeout period, the instance shuts
    /// down forcibly
    /// without flushing the file system caches and metadata.
    force: ?bool = null,

    /// The IDs of the instances.
    ///
    /// Constraints: Up to 1000 instance IDs. We recommend breaking up this request
    /// into
    /// smaller batches.
    instance_ids: []const []const u8,

    /// Specifies whether to bypass the graceful OS shutdown process when the
    /// instance is
    /// terminated.
    ///
    /// Default: `false`
    skip_os_shutdown: ?bool = null,
};

pub const TerminateInstancesOutput = struct {
    /// Information about the terminated instances.
    terminating_instances: ?[]const InstanceStateChange = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *TerminateInstancesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: TerminateInstancesInput, options: Options) !TerminateInstancesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: TerminateInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=TerminateInstances&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.force) |v| {
        try body_buf.appendSlice(alloc, "&Force=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !TerminateInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: TerminateInstancesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instancesSet")) {
                    result.terminating_instances = try serde.deserializeInstanceStateChangeList(&reader, alloc, "item");
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
