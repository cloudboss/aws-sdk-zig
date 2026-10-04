const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Task = @import("task.zig").Task;

pub const StopTaskInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster that hosts
    /// the task to stop. If you do not specify a cluster, the default cluster is
    /// assumed.
    cluster: ?[]const u8 = null,

    /// An optional message specified when a task is stopped. For example, if you're
    /// using a custom scheduler, you can use this parameter to specify the reason
    /// for stopping the task here, and the message appears in subsequent
    /// [DescribeTasks](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeTasks.html)> API operations on this task.
    reason: ?[]const u8 = null,

    /// Thefull Amazon Resource Name (ARN) of the task.
    task: []const u8,

    pub const json_field_names = .{
        .cluster = "cluster",
        .reason = "reason",
        .task = "task",
    };
};

pub const StopTaskOutput = struct {
    /// The task that was stopped.
    task: ?Task = null,

    pub const json_field_names = .{
        .task = "task",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopTaskInput, options: CallOptions) !StopTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.StopTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StopTaskOutput, body, allocator);
}
