const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Trace = @import("trace.zig").Trace;

pub const BatchGetTracesInput = struct {
    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// Specify the trace IDs of requests for which to retrieve segments.
    trace_ids: []const []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .trace_ids = "TraceIds",
    };
};

pub const BatchGetTracesOutput = struct {
    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// Full traces for the specified requests.
    traces: ?[]const Trace = null,

    /// Trace IDs of requests that haven't been processed.
    unprocessed_trace_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .traces = "Traces",
        .unprocessed_trace_ids = "UnprocessedTraceIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetTracesInput, options: CallOptions) !BatchGetTracesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "xray", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetTracesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/Traces";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TraceIds\":");
    try aws.json.writeValue(@TypeOf(input.trace_ids), input.trace_ids, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetTracesOutput {
    const result: BatchGetTracesOutput = try aws.json.parseJsonObject(
        BatchGetTracesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
