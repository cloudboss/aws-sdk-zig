const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StepStatus = @import("step_status.zig").StepStatus;

pub const RetryWorkflowStepInput = struct {
    /// The ID of the step.
    id: []const u8,

    /// The ID of the step group.
    step_group_id: []const u8,

    /// The ID of the migration workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .step_group_id = "stepGroupId",
        .workflow_id = "workflowId",
    };
};

pub const RetryWorkflowStepOutput = struct {
    /// The ID of the step.
    id: ?[]const u8 = null,

    /// The status of the step.
    status: ?StepStatus = null,

    /// The ID of the step group.
    step_group_id: ?[]const u8 = null,

    /// The ID of the migration workflow.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .status = "status",
        .step_group_id = "stepGroupId",
        .workflow_id = "workflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetryWorkflowStepInput, options: CallOptions) !RetryWorkflowStepOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "migrationhub-orchestrator", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RetryWorkflowStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/retryworkflowstep/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "stepGroupId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.step_group_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "workflowId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.workflow_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetryWorkflowStepOutput {
    var result: RetryWorkflowStepOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RetryWorkflowStepOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
