const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CompleteLifecycleActionInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The action for the group to take. You can specify either `CONTINUE` or
    /// `ABANDON`.
    lifecycle_action_result: []const u8,

    /// A universally unique identifier (UUID) that identifies a specific lifecycle
    /// action
    /// associated with an instance. Amazon EC2 Auto Scaling sends this token to the
    /// notification target you
    /// specified when you created the lifecycle hook.
    lifecycle_action_token: ?[]const u8 = null,

    /// The name of the lifecycle hook.
    lifecycle_hook_name: []const u8,
};

pub const CompleteLifecycleActionOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CompleteLifecycleActionInput, options: CallOptions) !CompleteLifecycleActionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CompleteLifecycleActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CompleteLifecycleAction&Version=2011-01-01");
    try body_buf.appendSlice(allocator, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.auto_scaling_group_name);
    if (input.instance_id) |v| {
        try body_buf.appendSlice(allocator, "&InstanceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&LifecycleActionResult=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.lifecycle_action_result);
    if (input.lifecycle_action_token) |v| {
        try body_buf.appendSlice(allocator, "&LifecycleActionToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&LifecycleHookName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.lifecycle_hook_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CompleteLifecycleActionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: CompleteLifecycleActionOutput = .{};

    return result;
}
