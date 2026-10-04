const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskState = @import("task_state.zig").TaskState;

pub const DescribeTaskInput = struct {
    /// The ID of the task to be described.
    task_id: []const u8,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub const DescribeTaskOutput = struct {
    /// When the task was completed.
    completed_at: ?i64 = null,

    /// When the `CreateTask` operation was called.
    created_at: ?i64 = null,

    /// The description provided of the task and managed devices.
    description: ?[]const u8 = null,

    /// When the state of the task was last updated.
    last_updated_at: ?i64 = null,

    /// The current state of the task.
    state: ?TaskState = null,

    /// Optional metadata that you assign to a resource. You can use tags to
    /// categorize a resource
    /// in different ways, such as by purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The managed devices that the task was sent to.
    targets: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the task.
    task_arn: ?[]const u8 = null,

    /// The ID of the task.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .created_at = "createdAt",
        .description = "description",
        .last_updated_at = "lastUpdatedAt",
        .state = "state",
        .tags = "tags",
        .targets = "targets",
        .task_arn = "taskArn",
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTaskInput, options: CallOptions) !DescribeTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snow-device-management", "Snow Device Management", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/task/");
    try path_buf.appendSlice(allocator, input.task_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTaskOutput {
    const result: DescribeTaskOutput = try aws.json.parseJsonObject(
        DescribeTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
