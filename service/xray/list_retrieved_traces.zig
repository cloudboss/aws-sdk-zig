const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TraceFormatType = @import("trace_format_type.zig").TraceFormatType;
const RetrievalStatus = @import("retrieval_status.zig").RetrievalStatus;
const RetrievedTrace = @import("retrieved_trace.zig").RetrievedTrace;

pub const ListRetrievedTracesInput = struct {
    /// Specify the pagination token returned by a previous request to retrieve the
    /// next page of indexes.
    next_token: ?[]const u8 = null,

    /// Retrieval token.
    retrieval_token: []const u8,

    /// Format of the requested traces.
    trace_format: ?TraceFormatType = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .retrieval_token = "RetrievalToken",
        .trace_format = "TraceFormat",
    };
};

pub const ListRetrievedTracesOutput = struct {
    /// Specify the pagination token returned by a previous request to retrieve the
    /// next page of indexes.
    next_token: ?[]const u8 = null,

    /// Status of the retrieval.
    retrieval_status: ?RetrievalStatus = null,

    /// Format of the requested traces.
    trace_format: ?TraceFormatType = null,

    /// Full traces for the specified requests.
    traces: ?[]const RetrievedTrace = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .retrieval_status = "RetrievalStatus",
        .trace_format = "TraceFormat",
        .traces = "Traces",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRetrievedTracesInput, options: CallOptions) !ListRetrievedTracesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRetrievedTracesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListRetrievedTraces";

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
    try body_buf.appendSlice(allocator, "\"RetrievalToken\":");
    try aws.json.writeValue(@TypeOf(input.retrieval_token), input.retrieval_token, allocator, &body_buf);
    has_prev = true;
    if (input.trace_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TraceFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRetrievedTracesOutput {
    var result: ListRetrievedTracesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRetrievedTracesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
