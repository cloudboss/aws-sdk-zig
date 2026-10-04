const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;

pub const DeleteWorkflowRunInput = struct {
    /// The name of the workflow definition containing the workflow run.
    workflow_definition_name: []const u8,

    /// The unique identifier of the workflow run to delete.
    workflow_run_id: []const u8,

    pub const json_field_names = .{
        .workflow_definition_name = "workflowDefinitionName",
        .workflow_run_id = "workflowRunId",
    };
};

pub const DeleteWorkflowRunOutput = struct {
    /// The status of the workflow run after deletion request.
    status: WorkflowRunStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteWorkflowRunInput, options: CallOptions) !DeleteWorkflowRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteWorkflowRunInput, config: *aws.Config) !aws.http.Request {
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
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteWorkflowRunOutput {
    var result: DeleteWorkflowRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteWorkflowRunOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
