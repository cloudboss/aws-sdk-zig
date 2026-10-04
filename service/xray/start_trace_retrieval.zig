const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartTraceRetrievalInput = struct {
    /// The end of the time range to retrieve traces. The range is inclusive, so the
    /// specified end time is included in the query. Specified as epoch time,
    /// the number of seconds since January 1, 1970, 00:00:00 UTC.
    end_time: i64,

    /// The start of the time range to retrieve traces. The range is inclusive, so
    /// the specified start time is included in the query.
    /// Specified as epoch time, the number of seconds since January 1, 1970,
    /// 00:00:00 UTC.
    start_time: i64,

    /// Specify the trace IDs of the traces to be retrieved.
    trace_ids: []const []const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
        .trace_ids = "TraceIds",
    };
};

pub const StartTraceRetrievalOutput = struct {
    /// Retrieval token.
    retrieval_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .retrieval_token = "RetrievalToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTraceRetrievalInput, options: CallOptions) !StartTraceRetrievalOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTraceRetrievalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartTraceRetrieval";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTraceRetrievalOutput {
    const result: StartTraceRetrievalOutput = try aws.json.parseJsonObject(
        StartTraceRetrievalOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
