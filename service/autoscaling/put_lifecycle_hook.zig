const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const PutLifecycleHookInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The action the Auto Scaling group takes when the lifecycle hook timeout
    /// elapses or if an
    /// unexpected failure occurs. The default value is `ABANDON`.
    ///
    /// Valid values: `CONTINUE` | `ABANDON`
    default_result: ?[]const u8 = null,

    /// The maximum time, in seconds, that can elapse before the lifecycle hook
    /// times out. The
    /// range is from `30` to `7200` seconds. The default value is
    /// `3600` seconds (1 hour).
    heartbeat_timeout: ?i32 = null,

    /// The name of the lifecycle hook.
    lifecycle_hook_name: []const u8,

    /// The lifecycle transition. For Auto Scaling groups, there are two major
    /// lifecycle
    /// transitions.
    ///
    /// * To create a lifecycle hook for scale-out events, specify
    /// `autoscaling:EC2_INSTANCE_LAUNCHING`.
    ///
    /// * To create a lifecycle hook for scale-in events, specify
    /// `autoscaling:EC2_INSTANCE_TERMINATING`.
    ///
    /// Required for new lifecycle hooks, but optional when updating existing hooks.
    lifecycle_transition: ?[]const u8 = null,

    /// Additional information that you want to include any time Amazon EC2 Auto
    /// Scaling sends a message to
    /// the notification target.
    notification_metadata: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the notification target that Amazon EC2
    /// Auto Scaling uses to notify
    /// you when an instance is in a wait state for the lifecycle hook. You can
    /// specify either
    /// an Amazon SNS topic or an Amazon SQS queue.
    ///
    /// If you specify an empty string, this overrides the current ARN.
    ///
    /// This operation uses the JSON format when sending notifications to an Amazon
    /// SQS queue, and
    /// an email key-value pair format when sending notifications to an Amazon SNS
    /// topic.
    ///
    /// When you specify a notification target, Amazon EC2 Auto Scaling sends it a
    /// test message. Test
    /// messages contain the following additional key-value pair: `"Event":
    /// "autoscaling:TEST_NOTIFICATION"`.
    notification_target_arn: ?[]const u8 = null,

    /// The ARN of the IAM role that allows the Auto Scaling group to publish to the
    /// specified
    /// notification target.
    ///
    /// Valid only if the notification target is an Amazon SNS topic or an Amazon
    /// SQS queue. Required
    /// for new lifecycle hooks, but optional when updating existing hooks.
    role_arn: ?[]const u8 = null,
};

pub const PutLifecycleHookOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutLifecycleHookInput, options: Options) !PutLifecycleHookOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutLifecycleHookInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=PutLifecycleHook&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.default_result) |v| {
        try body_buf.appendSlice(allocator, "&DefaultResult=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.heartbeat_timeout) |v| {
        try body_buf.appendSlice(allocator, "&HeartbeatTimeout=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&LifecycleHookName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.lifecycle_hook_name);
    if (input.lifecycle_transition) |v| {
        try body_buf.appendSlice(allocator, "&LifecycleTransition=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.notification_metadata) |v| {
        try body_buf.appendSlice(allocator, "&NotificationMetadata=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.notification_target_arn) |v| {
        try body_buf.appendSlice(allocator, "&NotificationTargetARN=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.role_arn) |v| {
        try body_buf.appendSlice(allocator, "&RoleARN=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutLifecycleHookOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutLifecycleHookOutput = .{};

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
