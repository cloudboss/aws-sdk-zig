const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Activity = @import("activity.zig").Activity;
const serde = @import("serde.zig");

pub const EnterStandbyInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The IDs of the instances. You can specify up to 20 instances.
    instance_ids: ?[]const []const u8 = null,

    /// Indicates whether to decrement the desired capacity of the Auto Scaling
    /// group by the number of
    /// instances moved to `Standby` mode.
    should_decrement_desired_capacity: bool,
};

pub const EnterStandbyOutput = struct {
    /// The activities related to moving instances into `Standby` mode.
    activities: ?[]const Activity = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnterStandbyInput, options: CallOptions) !EnterStandbyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EnterStandbyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=EnterStandby&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnterStandbyOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnterStandbyResult")) break;
            },
            else => {},
        }
    }

    var result: EnterStandbyOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Activities")) {
                    result.activities = try serde.deserializeActivities(allocator, &reader, "member");
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
