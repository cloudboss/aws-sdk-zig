const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const TaskConfiguration = @import("task_configuration.zig").TaskConfiguration;

pub const DescribeTaskInput = struct {
    /// The name of the task.
    task_name: []const u8,

    /// The version number of the task to retrieve. If not specified, returns the
    /// latest version.
    task_version: ?[]const u8 = null,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .task_name = "taskName",
        .task_version = "taskVersion",
        .workspace_name = "workspaceName",
    };
};

pub const DescribeTaskOutput = struct {
    /// The time the task was created, in Unix epoch time.
    created_at: i64,

    /// The description of the task.
    description: ?[]const u8 = null,

    /// The current lifecycle status of the task.
    status: ?ResourceStatus = null,

    /// The ARN of the task.
    task_arn: []const u8,

    /// The task execution configuration. Contains a
    /// [containerTaskConfiguration](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_ContainerTaskConfiguration.html) for custom container workloads.
    task_configuration: ?TaskConfiguration = null,

    /// The name of the task.
    task_name: []const u8,

    /// The time the task was last updated, in Unix epoch time.
    updated_at: i64,

    /// The version of the task.
    version: []const u8,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .status = "status",
        .task_arn = "taskArn",
        .task_configuration = "taskConfiguration",
        .task_name = "taskName",
        .updated_at = "updatedAt",
        .version = "version",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTaskInput, options: CallOptions) !DescribeTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/tasks/");
    try path_buf.appendSlice(allocator, input.task_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.task_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
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
