const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskConfiguration = @import("task_configuration.zig").TaskConfiguration;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateTaskInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    /// If you retry a request that completed successfully using the same client
    /// token, the server returns the
    /// cached result from the original successful request without performing the
    /// operation again.
    client_token: ?[]const u8 = null,

    /// A description of the task.
    description: ?[]const u8 = null,

    /// A list of key-value pairs that contain metadata for the task. For more
    /// information, see [Tagging your AWS IoT SiteWise
    /// resources](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/tag-resources.html) in the AWS IoT SiteWise User Guide.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The task execution configuration. Specify a
    /// [containerTaskConfiguration](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_ContainerTaskConfiguration.html) for custom container workloads.
    task_configuration: TaskConfiguration,

    /// The name of the task to create. Must be unique within the workspace.
    task_name: []const u8,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .tags = "tags",
        .task_configuration = "taskConfiguration",
        .task_name = "taskName",
        .workspace_name = "workspaceName",
    };
};

pub const CreateTaskOutput = struct {
    /// The current lifecycle status of the task.
    status: ?ResourceStatus = null,

    /// The ARN of the created task.
    task_arn: []const u8,

    /// The name of the created task.
    task_name: []const u8,

    /// The version of the newly created task.
    version: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .task_arn = "taskArn",
        .task_name = "taskName",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTaskInput, options: CallOptions) !CreateTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/tasks");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"taskConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.task_configuration), input.task_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"taskName\":");
    try aws.json.writeValue(@TypeOf(input.task_name), input.task_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTaskOutput {
    const result: CreateTaskOutput = try aws.json.parseJsonObject(
        CreateTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
