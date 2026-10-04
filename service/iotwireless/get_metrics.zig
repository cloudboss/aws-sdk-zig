const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SummaryMetricQuery = @import("summary_metric_query.zig").SummaryMetricQuery;
const SummaryMetricQueryResult = @import("summary_metric_query_result.zig").SummaryMetricQueryResult;

pub const GetMetricsInput = struct {
    /// The list of queries to retrieve the summary metrics.
    summary_metric_queries: ?[]const SummaryMetricQuery = null,

    pub const json_field_names = .{
        .summary_metric_queries = "SummaryMetricQueries",
    };
};

pub const GetMetricsOutput = struct {
    /// The list of summary metrics that were retrieved.
    summary_metric_query_results: ?[]const SummaryMetricQueryResult = null,

    pub const json_field_names = .{
        .summary_metric_query_results = "SummaryMetricQueryResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMetricsInput, options: CallOptions) !GetMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/metrics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.summary_metric_queries) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SummaryMetricQueries\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMetricsOutput {
    const result: GetMetricsOutput = try aws.json.parseJsonObject(
        GetMetricsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
