const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;

pub const GetWorkflowRunInput = struct {
    /// The name of the workflow definition containing the workflow run.
    workflow_definition_name: []const u8,

    /// The unique identifier of the workflow run to retrieve.
    workflow_run_id: []const u8,

    pub const json_field_names = .{
        .workflow_definition_name = "workflowDefinitionName",
        .workflow_run_id = "workflowRunId",
    };
};

pub const GetWorkflowRunOutput = struct {
    /// The timestamp when the workflow run completed execution, if applicable.
    ended_at: ?i64 = null,

    /// The CloudWatch log group name for this workflow run's logs.
    log_group_name: ?[]const u8 = null,

    /// The ID of the AI model being used for this workflow run.
    model_id: []const u8,

    /// The timestamp when the workflow run started execution.
    started_at: i64,

    /// The current execution status of the workflow run.
    status: WorkflowRunStatus,

    /// The Amazon Resource Name (ARN) of the workflow run.
    workflow_run_arn: []const u8,

    /// The unique identifier of the workflow run.
    workflow_run_id: []const u8,

    pub const json_field_names = .{
        .ended_at = "endedAt",
        .log_group_name = "logGroupName",
        .model_id = "modelId",
        .started_at = "startedAt",
        .status = "status",
        .workflow_run_arn = "workflowRunArn",
        .workflow_run_id = "workflowRunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowRunInput, options: CallOptions) !GetWorkflowRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "nova-act", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("nova-act", "Nova Act", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflow-definitions/");
    try path_buf.appendSlice(allocator, input.workflow_definition_name);
    try path_buf.appendSlice(allocator, "/workflow-runs/");
    try path_buf.appendSlice(allocator, input.workflow_run_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowRunOutput {
    var result: GetWorkflowRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWorkflowRunOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
