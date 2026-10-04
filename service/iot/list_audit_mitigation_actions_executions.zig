const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditMitigationActionsExecutionStatus = @import("audit_mitigation_actions_execution_status.zig").AuditMitigationActionsExecutionStatus;
const AuditMitigationActionExecutionMetadata = @import("audit_mitigation_action_execution_metadata.zig").AuditMitigationActionExecutionMetadata;

pub const ListAuditMitigationActionsExecutionsInput = struct {
    /// Specify this filter to limit results to those with a specific status.
    action_status: ?AuditMitigationActionsExecutionStatus = null,

    /// Specify this filter to limit results to those that were applied to a
    /// specific audit finding.
    finding_id: []const u8,

    /// The maximum number of results to return at one time. The default is 25.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// Specify this filter to limit results to actions for a specific audit
    /// mitigation actions task.
    task_id: []const u8,

    pub const json_field_names = .{
        .action_status = "actionStatus",
        .finding_id = "findingId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .task_id = "taskId",
    };
};

pub const ListAuditMitigationActionsExecutionsOutput = struct {
    /// A set of task execution results based on the input parameters. Details
    /// include the mitigation action applied, start time, and task status.
    actions_executions: ?[]const AuditMitigationActionExecutionMetadata = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions_executions = "actionsExecutions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAuditMitigationActionsExecutionsInput, options: CallOptions) !ListAuditMitigationActionsExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAuditMitigationActionsExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audit/mitigationactions/executions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.action_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "actionStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "findingId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.finding_id);
    query_has_prev = true;
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
    try query_buf.appendSlice(allocator, "taskId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.task_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAuditMitigationActionsExecutionsOutput {
    const result: ListAuditMitigationActionsExecutionsOutput = try aws.json.parseJsonObject(
        ListAuditMitigationActionsExecutionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
