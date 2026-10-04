const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClientInfo = @import("client_info.zig").ClientInfo;
const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;

pub const CreateWorkflowRunInput = struct {
    /// Information about the client making the request, including compatibility
    /// version and SDK version.
    client_info: ClientInfo,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The CloudWatch log group name for storing workflow execution logs.
    log_group_name: ?[]const u8 = null,

    /// The ID of the AI model to use for workflow execution.
    model_id: []const u8,

    /// The name of the workflow definition to execute.
    workflow_definition_name: []const u8,

    pub const json_field_names = .{
        .client_info = "clientInfo",
        .client_token = "clientToken",
        .log_group_name = "logGroupName",
        .model_id = "modelId",
        .workflow_definition_name = "workflowDefinitionName",
    };
};

pub const CreateWorkflowRunOutput = struct {
    /// The initial status of the workflow run after creation.
    status: WorkflowRunStatus,

    /// The unique identifier for the created workflow run.
    workflow_run_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .workflow_run_id = "workflowRunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkflowRunInput, options: CallOptions) !CreateWorkflowRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkflowRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("nova-act", "Nova Act", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflow-definitions/");
    try path_buf.appendSlice(allocator, input.workflow_definition_name);
    try path_buf.appendSlice(allocator, "/workflow-runs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientInfo\":");
    try aws.json.writeValue(@TypeOf(input.client_info), input.client_info, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_group_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logGroupName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"modelId\":");
    try aws.json.writeValue(@TypeOf(input.model_id), input.model_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkflowRunOutput {
    const result: CreateWorkflowRunOutput = try aws.json.parseJsonObject(
        CreateWorkflowRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
