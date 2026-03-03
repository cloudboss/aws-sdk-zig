const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Activity = @import("activity.zig").Activity;
const serde = @import("serde.zig");

pub const TerminateInstanceInAutoScalingGroupInput = struct {
    /// The ID of the instance.
    instance_id: []const u8,

    /// Indicates whether terminating the instance also decrements the size of the
    /// Auto Scaling
    /// group.
    should_decrement_desired_capacity: bool,
};

pub const TerminateInstanceInAutoScalingGroupOutput = struct {
    /// A scaling activity.
    activity: ?Activity = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TerminateInstanceInAutoScalingGroupInput, options: Options) !TerminateInstanceInAutoScalingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "autoscaling");

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

fn serializeRequest(allocator: std.mem.Allocator, input: TerminateInstanceInAutoScalingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=TerminateInstanceInAutoScalingGroup&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&InstanceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.instance_id);
    try body_buf.appendSlice(allocator, "&ShouldDecrementDesiredCapacity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.should_decrement_desired_capacity) "true" else "false");

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
                if (std.mem.eql(u8, e.local, "Activity")) {
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "ActiveInstanceRefreshNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .active_instance_refresh_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchError")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceRefreshInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .instance_refresh_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IrreversibleInstanceRefreshFault")) {
        return .{ .arena = arena, .kind = .{ .irreversible_instance_refresh_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceContentionFault")) {
        return .{ .arena = arena, .kind = .{ .resource_contention_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseFault")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScalingActivityInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .scaling_activity_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleFailure")) {
        return .{ .arena = arena, .kind = .{ .service_linked_role_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
