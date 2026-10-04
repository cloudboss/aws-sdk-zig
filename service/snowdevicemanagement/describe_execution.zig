const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionState = @import("execution_state.zig").ExecutionState;

pub const DescribeExecutionInput = struct {
    /// The ID of the managed device.
    managed_device_id: []const u8,

    /// The ID of the task that the action is describing.
    task_id: []const u8,

    pub const json_field_names = .{
        .managed_device_id = "managedDeviceId",
        .task_id = "taskId",
    };
};

pub const DescribeExecutionOutput = struct {
    /// The ID of the execution.
    execution_id: ?[]const u8 = null,

    /// When the status of the execution was last updated.
    last_updated_at: ?i64 = null,

    /// The ID of the managed device that the task is being executed on.
    managed_device_id: ?[]const u8 = null,

    /// When the execution began.
    started_at: ?i64 = null,

    /// The current state of the execution.
    state: ?ExecutionState = null,

    /// The ID of the task being executed on the device.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_id = "executionId",
        .last_updated_at = "lastUpdatedAt",
        .managed_device_id = "managedDeviceId",
        .started_at = "startedAt",
        .state = "state",
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeExecutionInput, options: CallOptions) !DescribeExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snow-device-management", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snow-device-management", "Snow Device Management", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/task/");
    try path_buf.appendSlice(allocator, input.task_id);
    try path_buf.appendSlice(allocator, "/execution/");
    try path_buf.appendSlice(allocator, input.managed_device_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeExecutionOutput {
    var result: DescribeExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
