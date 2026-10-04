const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionEnvironmentVariables = @import("execution_environment_variables.zig").ExecutionEnvironmentVariables;
const MountOverrides = @import("mount_overrides.zig").MountOverrides;

pub const StartPipelineExecutionInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    /// If you retry a request that completed successfully using the same client
    /// token, the server returns the
    /// cached result from the original successful request without performing the
    /// operation again.
    client_token: ?[]const u8 = null,

    /// Runtime environment variable overrides for the execution. Includes global
    /// variables
    /// that apply to all compute nodes and computeNodes for per-node overrides.
    /// These take the highest
    /// priority in the environment variable hierarchy.
    execution_environment_variable_overrides: ?ExecutionEnvironmentVariables = null,

    /// Runtime mount overrides for the execution. Overrides are merged by mount
    /// name into
    /// each listed compute node's task-defined mounts: a matching name replaces the
    /// task-defined
    /// mount, a new name adds a mount, and task-defined mounts not referenced
    /// remain unchanged.
    /// Compute nodes not listed use their task-defined mounts as-is.
    execution_mount_overrides: ?MountOverrides = null,

    /// Scheduling priority for the execution. Lower values indicate higher
    /// priority. Defaults to 2 when not specified.
    execution_priority: ?i32 = null,

    /// The name of the pipeline to execute.
    pipeline_name: []const u8,

    /// The name of the workspace containing the pipeline.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .execution_environment_variable_overrides = "executionEnvironmentVariableOverrides",
        .execution_mount_overrides = "executionMountOverrides",
        .execution_priority = "executionPriority",
        .pipeline_name = "pipelineName",
        .workspace_name = "workspaceName",
    };
};

pub const StartPipelineExecutionOutput = struct {
    /// The unique identifier of the created pipeline execution.
    pipeline_execution_id: []const u8,

    pub const json_field_names = .{
        .pipeline_execution_id = "pipelineExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartPipelineExecutionInput, options: CallOptions) !StartPipelineExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartPipelineExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/pipelines/");
    try path_buf.appendSlice(allocator, input.pipeline_name);
    try path_buf.appendSlice(allocator, "/executions");
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
    if (input.execution_environment_variable_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionEnvironmentVariableOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_mount_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionMountOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionPriority\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartPipelineExecutionOutput {
    const result: StartPipelineExecutionOutput = try aws.json.parseJsonObject(
        StartPipelineExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
