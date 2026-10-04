const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditTaskStatus = @import("audit_task_status.zig").AuditTaskStatus;
const AuditTaskType = @import("audit_task_type.zig").AuditTaskType;
const AuditTaskMetadata = @import("audit_task_metadata.zig").AuditTaskMetadata;

pub const ListAuditTasksInput = struct {
    /// The end of the time period.
    end_time: i64,

    /// The maximum number of results to return at one time. The default is 25.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// The beginning of the time period. Audit information is retained for a
    /// limited time (90 days). Requesting a start time prior to what is retained
    /// results in an "InvalidRequestException".
    start_time: i64,

    /// A filter to limit the output to audits with the specified completion
    /// status: can be one of "IN_PROGRESS", "COMPLETED", "FAILED", or "CANCELED".
    task_status: ?AuditTaskStatus = null,

    /// A filter to limit the output to the specified type of audit: can be one of
    /// "ON_DEMAND_AUDIT_TASK" or "SCHEDULED__AUDIT_TASK".
    task_type: ?AuditTaskType = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .start_time = "startTime",
        .task_status = "taskStatus",
        .task_type = "taskType",
    };
};

pub const ListAuditTasksOutput = struct {
    /// A token that can be used to retrieve the next set of results, or `null`
    /// if there are no additional results.
    next_token: ?[]const u8 = null,

    /// The audits that were performed during the specified time period.
    tasks: ?[]const AuditTaskMetadata = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tasks = "tasks",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAuditTasksInput, options: CallOptions) !ListAuditTasksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAuditTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audit/tasks";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "endTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
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
    if (input.task_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "taskType=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAuditTasksOutput {
    const result: ListAuditTasksOutput = try aws.json.parseJsonObject(
        ListAuditTasksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
