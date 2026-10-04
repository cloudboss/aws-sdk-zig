const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduledUpdateGroupActionRequest = @import("scheduled_update_group_action_request.zig").ScheduledUpdateGroupActionRequest;
const FailedScheduledUpdateGroupActionRequest = @import("failed_scheduled_update_group_action_request.zig").FailedScheduledUpdateGroupActionRequest;
const serde = @import("serde.zig");

pub const BatchPutScheduledUpdateGroupActionInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// One or more scheduled actions. The maximum number allowed is 50.
    scheduled_update_group_actions: []const ScheduledUpdateGroupActionRequest,
};

pub const BatchPutScheduledUpdateGroupActionOutput = struct {
    /// The names of the scheduled actions that could not be created or updated,
    /// including an
    /// error message.
    failed_scheduled_update_group_actions: ?[]const FailedScheduledUpdateGroupActionRequest = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchPutScheduledUpdateGroupActionInput, options: CallOptions) !BatchPutScheduledUpdateGroupActionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchPutScheduledUpdateGroupActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=BatchPutScheduledUpdateGroupAction&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    for (input.scheduled_update_group_actions, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.desired_capacity) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledUpdateGroupActions.member.{d}.DesiredCapacity=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.end_time) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledUpdateGroupActions.member.{d}.EndTime=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.max_size) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledUpdateGroupActions.member.{d}.MaxSize=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.min_size) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledUpdateGroupActions.member.{d}.MinSize=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.recurrence) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledUpdateGroupActions.member.{d}.Recurrence=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledUpdateGroupActions.member.{d}.ScheduledActionName=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.scheduled_action_name);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.start_time) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledUpdateGroupActions.member.{d}.StartTime=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.time_zone) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ScheduledUpdateGroupActions.member.{d}.TimeZone=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchPutScheduledUpdateGroupActionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BatchPutScheduledUpdateGroupActionResult")) break;
            },
            else => {},
        }
    }

    var result: BatchPutScheduledUpdateGroupActionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailedScheduledUpdateGroupActions")) {
                    result.failed_scheduled_update_group_actions = try serde.deserializeFailedScheduledUpdateGroupActionRequests(allocator, &reader, "member");
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
