const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowStepGroupSummary = @import("workflow_step_group_summary.zig").WorkflowStepGroupSummary;

pub const ListWorkflowStepGroupsInput = struct {
    /// The maximum number of results that can be returned.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// The ID of the migration workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .workflow_id = "workflowId",
    };
};

pub const ListWorkflowStepGroupsOutput = struct {
    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// The summary of step groups in a migration workflow.
    workflow_step_groups_summary: ?[]const WorkflowStepGroupSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .workflow_step_groups_summary = "workflowStepGroupsSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkflowStepGroupsInput, options: CallOptions) !ListWorkflowStepGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkflowStepGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-orchestrator", "MigrationHubOrchestrator", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/workflowstepgroups";

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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "workflowId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.workflow_id);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkflowStepGroupsOutput {
    var result: ListWorkflowStepGroupsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListWorkflowStepGroupsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
