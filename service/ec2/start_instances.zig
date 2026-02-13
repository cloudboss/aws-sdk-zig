const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceStateChange = @import("instance_state_change.zig").InstanceStateChange;
const serde = @import("serde.zig");

/// Starts an Amazon EBS-backed instance that you've previously stopped.
///
/// Instances that use Amazon EBS volumes as their root devices can be quickly
/// stopped and
/// started. When an instance is stopped, the compute resources are released and
/// you are not
/// billed for instance usage. However, your root partition Amazon EBS volume
/// remains and
/// continues to persist your data, and you are charged for Amazon EBS volume
/// usage. You can
/// restart your instance at any time. Every time you start your instance,
/// Amazon EC2
/// charges a one-minute minimum for instance usage, and thereafter charges per
/// second for
/// instance usage.
///
/// Before stopping an instance, make sure it is in a state from which it can be
/// restarted. Stopping an instance does not preserve data stored in RAM.
///
/// Performing this operation on an instance that uses an instance store as its
/// root
/// device returns an error.
///
/// If you attempt to start a T3 instance with `host` tenancy and the
/// `unlimited` CPU credit option, the request fails. The
/// `unlimited` CPU credit option is not supported on Dedicated Hosts. Before
/// you start the instance, either change its CPU credit option to `standard`,
/// or
/// change its tenancy to `default` or `dedicated`.
///
/// For more information, see [Stop and start Amazon EC2
/// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html) in the *Amazon EC2 User Guide*.
pub const StartInstancesInput = struct {
    /// Reserved.
    additional_info: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IDs of the instances.
    instance_ids: []const []const u8,
};

pub const StartInstancesOutput = struct {
    /// Information about the started instances.
    starting_instances: ?[]const InstanceStateChange = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *StartInstancesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: StartInstancesInput, options: Options) !StartInstancesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: StartInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=StartInstances&Version=2016-11-15");
    if (input.additional_info) |v| {
        try body_buf.appendSlice(alloc, "&AdditionalInfo=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    for (input.instance_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceIds.InstanceId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: StartInstancesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instancesSet")) {
                    result.starting_instances = try serde.deserializeInstanceStateChangeList(&reader, alloc, "item");
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
