const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Event = @import("event.zig").Event;

pub const GetDurableExecutionHistoryInput = struct {
    /// The Amazon Resource Name (ARN) of the durable execution.
    durable_execution_arn: []const u8,

    /// Specifies whether to include execution data such as step results and
    /// callback payloads in the history events. Set to `true` to include data, or
    /// `false` to exclude it for a more compact response. The default is `true`.
    include_execution_data: ?bool = null,

    /// If `NextMarker` was returned from a previous request, use this value to
    /// retrieve the next page of results. Each pagination token expires after 24
    /// hours.
    marker: ?[]const u8 = null,

    /// The maximum number of history events to return per call. You can use
    /// `Marker` to retrieve additional pages of results. The default is 100 and the
    /// maximum allowed is 1000. A value of 0 uses the default.
    max_items: ?i32 = null,

    /// When set to `true`, returns the history events in reverse chronological
    /// order (newest first). By default, events are returned in chronological order
    /// (oldest first).
    reverse_order: ?bool = null,

    pub const json_field_names = .{
        .durable_execution_arn = "DurableExecutionArn",
        .include_execution_data = "IncludeExecutionData",
        .marker = "Marker",
        .max_items = "MaxItems",
        .reverse_order = "ReverseOrder",
    };
};

pub const GetDurableExecutionHistoryOutput = struct {
    /// An array of execution history events, ordered chronologically unless
    /// `ReverseOrder` is set to `true`. Each event represents a significant
    /// occurrence during the execution, such as step completion or callback
    /// resolution.
    events: ?[]const Event = null,

    /// If present, indicates that more history events are available. Use this value
    /// as the `Marker` parameter in a subsequent request to retrieve the next page
    /// of results.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "Events",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDurableExecutionHistoryInput, options: CallOptions) !GetDurableExecutionHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDurableExecutionHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-12-01/durable-executions/");
    try path_buf.appendSlice(allocator, input.durable_execution_arn);
    try path_buf.appendSlice(allocator, "/history");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_execution_data) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "IncludeExecutionData=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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
    if (input.reverse_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ReverseOrder=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDurableExecutionHistoryOutput {
    var result: GetDurableExecutionHistoryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDurableExecutionHistoryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
