const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const Execution = @import("execution.zig").Execution;

pub const ListDurableExecutionsByFunctionInput = struct {
    /// Filter executions by name. Only executions with names that matches this
    /// string are returned.
    durable_execution_name: ?[]const u8 = null,

    /// The name or ARN of the Lambda function. You can specify a function name, a
    /// partial ARN, or a full ARN.
    function_name: []const u8,

    /// Pagination token from a previous request to continue retrieving results.
    marker: ?[]const u8 = null,

    /// Maximum number of executions to return (1-1000). Default is 100.
    max_items: ?i32 = null,

    /// The function version or alias. If not specified, lists executions for the
    /// $LATEST version.
    qualifier: ?[]const u8 = null,

    /// Set to true to return results in reverse chronological order (newest first).
    /// Default is false.
    reverse_order: ?bool = null,

    /// Filter executions that started after this timestamp (ISO 8601 format).
    started_after: ?i64 = null,

    /// Filter executions that started before this timestamp (ISO 8601 format).
    started_before: ?i64 = null,

    /// Filter executions by status. Valid values: RUNNING, SUCCEEDED, FAILED,
    /// TIMED_OUT, STOPPED.
    statuses: ?[]const ExecutionStatus = null,

    pub const json_field_names = .{
        .durable_execution_name = "DurableExecutionName",
        .function_name = "FunctionName",
        .marker = "Marker",
        .max_items = "MaxItems",
        .qualifier = "Qualifier",
        .reverse_order = "ReverseOrder",
        .started_after = "StartedAfter",
        .started_before = "StartedBefore",
        .statuses = "Statuses",
    };
};

pub const ListDurableExecutionsByFunctionOutput = struct {
    /// List of durable execution summaries matching the filter criteria.
    durable_executions: ?[]const Execution = null,

    /// Pagination token for retrieving additional results. Present only if there
    /// are more results available.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .durable_executions = "DurableExecutions",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDurableExecutionsByFunctionInput, options: CallOptions) !ListDurableExecutionsByFunctionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDurableExecutionsByFunctionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-12-01/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/durable-executions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.durable_execution_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "DurableExecutionName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Qualifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.reverse_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ReverseOrder=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.started_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "StartedAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.started_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "StartedBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.statuses) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "Statuses=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDurableExecutionsByFunctionOutput {
    var result: ListDurableExecutionsByFunctionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDurableExecutionsByFunctionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
