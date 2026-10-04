const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Failure = @import("failure.zig").Failure;
const ProtectedTask = @import("protected_task.zig").ProtectedTask;

pub const GetTaskProtectionInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster that hosts
    /// the service that the task sets exist in.
    cluster: []const u8,

    /// A list of up to 100 task IDs or full ARN entries.
    tasks: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .tasks = "tasks",
    };
};

pub const GetTaskProtectionOutput = struct {
    /// Any failures associated with the call.
    failures: ?[]const Failure = null,

    /// A list of tasks with the following information.
    ///
    /// * `taskArn`: The task ARN.
    /// * `protectionEnabled`: The protection status of the task. If scale-in
    ///   protection is turned on for a task, the value is `true`. Otherwise, it is
    ///   `false`.
    /// * `expirationDate`: The epoch time when protection for the task will expire.
    protected_tasks: ?[]const ProtectedTask = null,

    pub const json_field_names = .{
        .failures = "failures",
        .protected_tasks = "protectedTasks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTaskProtectionInput, options: CallOptions) !GetTaskProtectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTaskProtectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.GetTaskProtection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTaskProtectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTaskProtectionOutput, body, allocator);
}
