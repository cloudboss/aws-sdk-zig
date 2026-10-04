const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeNodeExecutionDetails = @import("compute_node_execution_details.zig").ComputeNodeExecutionDetails;
const ExecutionEnvironmentVariables = @import("execution_environment_variables.zig").ExecutionEnvironmentVariables;
const MountOverrides = @import("mount_overrides.zig").MountOverrides;
const PipelineExecutionStatus = @import("pipeline_execution_status.zig").PipelineExecutionStatus;

pub const DescribePipelineExecutionInput = struct {
    /// The maximum number of compute nodes to return per request. This is an upper
    /// bound; the actual number of results may be less. Default: 50.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the pipeline execution.
    pipeline_execution_id: []const u8,

    /// The name of the pipeline.
    pipeline_name: []const u8,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_name = "pipelineName",
        .workspace_name = "workspaceName",
    };
};

pub const DescribePipelineExecutionOutput = struct {
    /// A list of compute node execution details within this pipeline execution.
    compute_node_execution_details: ?[]const ComputeNodeExecutionDetails = null,

    /// The time the pipeline execution completed, in Unix epoch time.
    end_time: ?i64 = null,

    /// Scheduling priority for the execution. When not specified, defaults to
    /// lowest priority.
    execution_priority: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the pipeline execution.
    pipeline_execution_id: []const u8,

    /// The name of the pipeline.
    pipeline_name: []const u8,

    /// The pipeline version this execution ran against.
    pipeline_version: []const u8,

    /// The environment variables provided as input for the pipeline execution.
    request_environment_variables: ?ExecutionEnvironmentVariables = null,

    /// The mount overrides provided as input for the pipeline execution. Present
    /// when mount overrides were supplied at execution time.
    request_mount_overrides: ?MountOverrides = null,

    /// The time the pipeline execution started, in Unix epoch time.
    start_time: ?i64 = null,

    /// The current execution status of the pipeline.
    status: ?PipelineExecutionStatus = null,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .compute_node_execution_details = "computeNodeExecutionDetails",
        .end_time = "endTime",
        .execution_priority = "executionPriority",
        .next_token = "nextToken",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_name = "pipelineName",
        .pipeline_version = "pipelineVersion",
        .request_environment_variables = "requestEnvironmentVariables",
        .request_mount_overrides = "requestMountOverrides",
        .start_time = "startTime",
        .status = "status",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePipelineExecutionInput, options: CallOptions) !DescribePipelineExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePipelineExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/pipelines/");
    try path_buf.appendSlice(allocator, input.pipeline_name);
    try path_buf.appendSlice(allocator, "/executions/");
    try path_buf.appendSlice(allocator, input.pipeline_execution_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePipelineExecutionOutput {
    const result: DescribePipelineExecutionOutput = try aws.json.parseJsonObject(
        DescribePipelineExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
