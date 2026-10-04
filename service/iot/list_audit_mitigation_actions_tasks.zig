const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditMitigationActionsTaskStatus = @import("audit_mitigation_actions_task_status.zig").AuditMitigationActionsTaskStatus;
const AuditMitigationActionsTaskMetadata = @import("audit_mitigation_actions_task_metadata.zig").AuditMitigationActionsTaskMetadata;

pub const ListAuditMitigationActionsTasksInput = struct {
    /// Specify this filter to limit results to tasks that were applied to results
    /// for a specific audit.
    audit_task_id: ?[]const u8 = null,

    /// Specify this filter to limit results to tasks that were completed or
    /// canceled on or before a specific date and time.
    end_time: i64,

    /// Specify this filter to limit results to tasks that were applied to a
    /// specific audit finding.
    finding_id: ?[]const u8 = null,

    /// The maximum number of results to return at one time. The default is 25.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// Specify this filter to limit results to tasks that began on or after a
    /// specific date and time.
    start_time: i64,

    /// Specify this filter to limit results to tasks that are in a specific state.
    task_status: ?AuditMitigationActionsTaskStatus = null,

    pub const json_field_names = .{
        .audit_task_id = "auditTaskId",
        .end_time = "endTime",
        .finding_id = "findingId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .start_time = "startTime",
        .task_status = "taskStatus",
    };
};

pub const ListAuditMitigationActionsTasksOutput = struct {
    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// The collection of audit mitigation tasks that matched the filter criteria.
    tasks: ?[]const AuditMitigationActionsTaskMetadata = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tasks = "tasks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAuditMitigationActionsTasksInput, options: CallOptions) !ListAuditMitigationActionsTasksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAuditMitigationActionsTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audit/mitigationactions/tasks";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.audit_task_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "auditTaskId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "endTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.finding_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "findingId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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
    try query_buf.appendSlice(allocator, "startTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.task_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "taskStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAuditMitigationActionsTasksOutput {
    const result: ListAuditMitigationActionsTasksOutput = try aws.json.parseJsonObject(
        ListAuditMitigationActionsTasksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
