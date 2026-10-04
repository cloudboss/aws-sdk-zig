const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Activity = @import("activity.zig").Activity;
const serde = @import("serde.zig");

pub const TerminateInstanceInAutoScalingGroupInput = struct {
    /// The name of the Auto Scaling group. Required when using `InstanceIds`.
    auto_scaling_group_name: ?[]const u8 = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The IDs of the instances. You can specify up to 100 instances.
    ///
    /// This parameter requires that you also specify `AutoScalingGroupName`.
    instance_ids: ?[]const []const u8 = null,

    /// Indicates whether terminating the instance also decrements the size of the
    /// Auto Scaling
    /// group.
    should_decrement_desired_capacity: bool,
};

pub const TerminateInstanceInAutoScalingGroupOutput = struct {
    /// The scaling activities related to terminating the instances from the Auto
    /// Scaling group.
    activities: ?[]const Activity = null,

    /// A scaling activity.
    activity: ?Activity = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TerminateInstanceInAutoScalingGroupInput, options: CallOptions) !TerminateInstanceInAutoScalingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TerminateInstanceInAutoScalingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=TerminateInstanceInAutoScalingGroup&Version=2011-01-01");
    if (input.auto_scaling_group_name) |v| {
        try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.instance_id) |v| {
        try body_buf.appendSlice(allocator, "&InstanceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.instance_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&ShouldDecrementDesiredCapacity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.should_decrement_desired_capacity) "true" else "false");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TerminateInstanceInAutoScalingGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TerminateInstanceInAutoScalingGroupResult")) break;
            },
            else => {},
        }
    }

    var result: TerminateInstanceInAutoScalingGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Activities")) {
                    result.activities = try serde.deserializeActivities(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Activity")) {
                    result.activity = try serde.deserializeActivity(allocator, &reader);
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
