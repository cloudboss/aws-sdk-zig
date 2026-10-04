const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipelineExecutionState = @import("pipeline_execution_state.zig").PipelineExecutionState;

pub const CancelPipelineExecutionInput = struct {
    /// The unique identifier of the pipeline execution.
    pipeline_execution_id: []const u8,

    /// The name of the pipeline.
    pipeline_name: []const u8,

    /// A message describing why the pipeline execution is being cancelled.
    reason: ?[]const u8 = null,

    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_name = "pipelineName",
        .reason = "reason",
        .workspace_name = "workspaceName",
    };
};

pub const CancelPipelineExecutionOutput = struct {
    /// The current execution state of the pipeline. Can only be CANCELLING or
    /// CANCELLED.
    state: PipelineExecutionState,

    pub const json_field_names = .{
        .state = "state",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelPipelineExecutionInput, options: CallOptions) !CancelPipelineExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelPipelineExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/pipelines/");
    try path_buf.appendSlice(allocator, input.pipeline_name);
    try path_buf.appendSlice(allocator, "/executions/");
    try path_buf.appendSlice(allocator, input.pipeline_execution_id);
    try path_buf.appendSlice(allocator, "/cancel");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reason\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelPipelineExecutionOutput {
    const result: CancelPipelineExecutionOutput = try aws.json.parseJsonObject(
        CancelPipelineExecutionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
