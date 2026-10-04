const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Session = @import("session.zig").Session;

pub const ExecuteCommandInput = struct {
    /// The Amazon Resource Name (ARN) or short name of the cluster the task is
    /// running in. If you do not specify a cluster, the default cluster is assumed.
    cluster: ?[]const u8 = null,

    /// The command to run on the container.
    command: []const u8,

    /// The name of the container to execute the command on. A container name only
    /// needs to be specified for tasks containing multiple containers.
    container: ?[]const u8 = null,

    /// Use this flag to run your command in interactive mode.
    interactive: ?bool = null,

    /// The Amazon Resource Name (ARN) or ID of the task the container is part of.
    task: []const u8,

    pub const json_field_names = .{
        .cluster = "cluster",
        .command = "command",
        .container = "container",
        .interactive = "interactive",
        .task = "task",
    };
};

pub const ExecuteCommandOutput = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the container.
    container_arn: ?[]const u8 = null,

    /// The name of the container.
    container_name: ?[]const u8 = null,

    /// Determines whether the execute command session is running in interactive
    /// mode. Amazon ECS only supports initiating interactive sessions, so you must
    /// specify `true` for this value.
    interactive: ?bool = null,

    /// The details of the SSM session that was created for this instance of
    /// execute-command.
    session: ?Session = null,

    /// The Amazon Resource Name (ARN) of the task.
    task_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .container_arn = "containerArn",
        .container_name = "containerName",
        .interactive = "interactive",
        .session = "session",
        .task_arn = "taskArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteCommandInput, options: CallOptions) !ExecuteCommandOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteCommandInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ExecuteCommand");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteCommandOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ExecuteCommandOutput, body, allocator);
}
