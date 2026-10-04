const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowStepSummary = @import("workflow_step_summary.zig").WorkflowStepSummary;

pub const ListWorkflowStepsInput = struct {
    /// The maximum number of results that can be returned.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// The ID of the step group.
    step_group_id: []const u8,

    /// The ID of the migration workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .step_group_id = "stepGroupId",
        .workflow_id = "workflowId",
    };
};

pub const ListWorkflowStepsOutput = struct {
    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// The summary of steps in a migration workflow.
    workflow_steps_summary: ?[]const WorkflowStepSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .workflow_steps_summary = "workflowStepsSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkflowStepsInput, options: CallOptions) !ListWorkflowStepsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkflowStepsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflow/");
    try path_buf.appendSlice(allocator, input.workflow_id);
    try path_buf.appendSlice(allocator, "/workflowstepgroups/");
    try path_buf.appendSlice(allocator, input.step_group_id);
    try path_buf.appendSlice(allocator, "/workflowsteps");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkflowStepsOutput {
    var result: ListWorkflowStepsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListWorkflowStepsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
