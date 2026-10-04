const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeNode = @import("compute_node.zig").ComputeNode;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreatePipelineInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    /// If you retry a request that completed successfully using the same client
    /// token, the server returns the
    /// cached result from the original successful request without performing the
    /// operation again.
    client_token: ?[]const u8 = null,

    /// The list of compute nodes that form the pipeline DAG. Each compute node
    /// references a task and can declare dependencies on other nodes.
    computations: []const ComputeNode,

    /// A description of the pipeline.
    description: ?[]const u8 = null,

    /// Environment variables shared across all compute nodes in the pipeline.
    /// Individual compute nodes can override these values with their own
    /// environment variables.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The name of the pipeline to create. Must be unique within the workspace.
    pipeline_name: []const u8,

    /// A list of key-value pairs that contain metadata for the pipeline. For more
    /// information, see [Tagging your AWS IoT SiteWise
    /// resources](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/tag-resources.html) in the AWS IoT SiteWise User Guide.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .computations = "computations",
        .description = "description",
        .environment_variables = "environmentVariables",
        .pipeline_name = "pipelineName",
        .tags = "tags",
        .workspace_name = "workspaceName",
    };
};

pub const CreatePipelineOutput = struct {
    /// The ARN of the created pipeline.
    pipeline_arn: []const u8,

    /// The name of the created pipeline.
    pipeline_name: []const u8,

    /// The current lifecycle status of the pipeline.
    status: ?ResourceStatus = null,

    /// The version of the newly created pipeline.
    version: []const u8,

    pub const json_field_names = .{
        .pipeline_arn = "pipelineArn",
        .pipeline_name = "pipelineName",
        .status = "status",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePipelineInput, options: CallOptions) !CreatePipelineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/pipelines");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"computations\":");
    try aws.json.writeValue(@TypeOf(input.computations), input.computations, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_variables) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"pipelineName\":");
    try aws.json.writeValue(@TypeOf(input.pipeline_name), input.pipeline_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePipelineOutput {
    const result: CreatePipelineOutput = try aws.json.parseJsonObject(
        CreatePipelineOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
