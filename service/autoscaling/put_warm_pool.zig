const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceReusePolicy = @import("instance_reuse_policy.zig").InstanceReusePolicy;
const WarmPoolState = @import("warm_pool_state.zig").WarmPoolState;
const serde = @import("serde.zig");

pub const PutWarmPoolInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// Indicates whether instances in the Auto Scaling group can be returned to the
    /// warm pool on
    /// scale in. The default is to terminate instances in the Auto Scaling group
    /// when the group scales
    /// in.
    instance_reuse_policy: ?InstanceReusePolicy = null,

    /// Specifies the maximum number of instances that are allowed to be in the warm
    /// pool or
    /// in any state except `Terminated` for the Auto Scaling group. This is an
    /// optional
    /// property. Specify it only if you do not want the warm pool size to be
    /// determined by the
    /// difference between the group's maximum capacity and its desired capacity.
    ///
    /// If a value for `MaxGroupPreparedCapacity` is not specified, Amazon EC2 Auto
    /// Scaling
    /// launches and maintains the difference between the group's maximum capacity
    /// and its
    /// desired capacity. If you specify a value for `MaxGroupPreparedCapacity`,
    /// Amazon EC2 Auto Scaling uses the difference between the
    /// `MaxGroupPreparedCapacity` and
    /// the desired capacity instead.
    ///
    /// The size of the warm pool is dynamic. Only when
    /// `MaxGroupPreparedCapacity` and `MinSize` are set to the
    /// same value does the warm pool have an absolute size.
    ///
    /// If the desired capacity of the Auto Scaling group is higher than the
    /// `MaxGroupPreparedCapacity`, the capacity of the warm pool is 0, unless
    /// you specify a value for `MinSize`. To remove a value that you previously
    /// set,
    /// include the property but specify -1 for the value.
    max_group_prepared_capacity: ?i32 = null,

    /// Specifies the minimum number of instances to maintain in the warm pool. This
    /// helps you
    /// to ensure that there is always a certain number of warmed instances
    /// available to handle
    /// traffic spikes. Defaults to 0 if not specified.
    min_size: ?i32 = null,

    /// Sets the instance state to transition to after the lifecycle actions are
    /// complete.
    /// Default is `Stopped`.
    pool_state: ?WarmPoolState = null,
};

pub const PutWarmPoolOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutWarmPoolInput, options: Options) !PutWarmPoolOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutWarmPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=PutWarmPool&Version=2011-01-01");
    try body_buf.appendSlice(alloc, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.auto_scaling_group_name);
    if (input.instance_reuse_policy) |v| {
        if (v.reuse_on_scale_in) |sv| {
            try body_buf.appendSlice(alloc, "&InstanceReusePolicy.ReuseOnScaleIn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.max_group_prepared_capacity) |v| {
        try body_buf.appendSlice(alloc, "&MaxGroupPreparedCapacity=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.min_size) |v| {
        try body_buf.appendSlice(alloc, "&MinSize=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.pool_state) |v| {
        try body_buf.appendSlice(alloc, "&PoolState=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutWarmPoolOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: PutWarmPoolOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
