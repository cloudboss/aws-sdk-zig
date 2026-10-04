const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartWorkflowRunInput = struct {
    /// A user-specified idempotency token. Idempotency ensures that an API request
    /// completes only once.
    /// With an idempotent request, if the original request completes successfully,
    /// the subsequent retries return the result from the original successful
    /// request and have no additional effect.
    client_token: ?[]const u8 = null,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    /// The system-generated unique ID of the workflow. To retrieve a list of
    /// workflow IDs, use ListWorkflows.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .project_name = "projectName",
        .space_name = "spaceName",
        .workflow_id = "workflowId",
    };
};

pub const StartWorkflowRunOutput = struct {
    /// The system-generated unique ID of the workflow run.
    id: []const u8,

    /// The name of the project in the space.
    project_name: []const u8,

    /// The name of the space.
    space_name: []const u8,

    /// The system-generated unique ID of the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .project_name = "projectName",
        .space_name = "spaceName",
        .workflow_id = "workflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartWorkflowRunInput, options: CallOptions) !StartWorkflowRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartWorkflowRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/spaces/");
    try path_buf.appendSlice(allocator, input.space_name);
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project_name);
    try path_buf.appendSlice(allocator, "/workflowRuns");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "workflowId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.workflow_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartWorkflowRunOutput {
    const result: StartWorkflowRunOutput = try aws.json.parseJsonObject(
        StartWorkflowRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
