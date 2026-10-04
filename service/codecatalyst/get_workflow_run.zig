const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;
const WorkflowRunStatusReason = @import("workflow_run_status_reason.zig").WorkflowRunStatusReason;

pub const GetWorkflowRunInput = struct {
    /// The ID of the workflow run. To retrieve a list of workflow run IDs, use
    /// ListWorkflowRuns.
    id: []const u8,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .project_name = "projectName",
        .space_name = "spaceName",
    };
};

pub const GetWorkflowRunOutput = struct {
    /// The date and time the workflow run ended, in coordinated universal time
    /// (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    end_time: ?i64 = null,

    /// The ID of the workflow run.
    id: []const u8,

    /// The date and time the workflow run status was last updated, in coordinated
    /// universal time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6)
    last_updated_time: i64,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    /// The date and time the workflow run began, in coordinated universal time
    /// (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6)
    start_time: i64,

    /// The status of the workflow run.
    status: WorkflowRunStatus,

    /// Information about the reasons for the status of the workflow run.
    status_reasons: ?[]const WorkflowRunStatusReason = null,

    /// The ID of the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .id = "id",
        .last_updated_time = "lastUpdatedTime",
        .project_name = "projectName",
        .space_name = "spaceName",
        .start_time = "startTime",
        .status = "status",
        .status_reasons = "statusReasons",
        .workflow_id = "workflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowRunInput, options: CallOptions) !GetWorkflowRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecatalyst", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/spaces/");
    try path_buf.appendSlice(allocator, input.space_name);
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project_name);
    try path_buf.appendSlice(allocator, "/workflowRuns/");
    try path_buf.appendSlice(allocator, input.id);
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
    const result: GetWorkflowRunOutput = try aws.json.parseJsonObject(
        GetWorkflowRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
