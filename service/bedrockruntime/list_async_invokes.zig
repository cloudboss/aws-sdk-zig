const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortAsyncInvocationBy = @import("sort_async_invocation_by.zig").SortAsyncInvocationBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const AsyncInvokeStatus = @import("async_invoke_status.zig").AsyncInvokeStatus;
const AsyncInvokeSummary = @import("async_invoke_summary.zig").AsyncInvokeSummary;

pub const ListAsyncInvokesInput = struct {
    /// The maximum number of invocations to return in one page of results.
    max_results: ?i32 = null,

    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// How to sort the response.
    sort_by: ?SortAsyncInvocationBy = null,

    /// The sorting order for the response.
    sort_order: ?SortOrder = null,

    /// Filter invocations by status.
    status_equals: ?AsyncInvokeStatus = null,

    /// Include invocations submitted after this time.
    submit_time_after: ?i64 = null,

    /// Include invocations submitted before this time.
    submit_time_before: ?i64 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
        .status_equals = "statusEquals",
        .submit_time_after = "submitTimeAfter",
        .submit_time_before = "submitTimeBefore",
    };
};

pub const ListAsyncInvokesOutput = struct {
    /// A list of invocation summaries.
    async_invoke_summaries: ?[]const AsyncInvokeSummary = null,

    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .async_invoke_summaries = "asyncInvokeSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAsyncInvokesInput, options: CallOptions) !ListAsyncInvokesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockfrontendservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAsyncInvokesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-runtime", "Bedrock Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/async-invoke";

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
    if (input.sort_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.sort_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortOrder=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.status_equals) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "statusEquals=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.submit_time_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "submitTimeAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.submit_time_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "submitTimeBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAsyncInvokesOutput {
    const result: ListAsyncInvokesOutput = try aws.json.parseJsonObject(
        ListAsyncInvokesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
