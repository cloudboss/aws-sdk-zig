const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetMetricDataQuery = @import("batch_get_metric_data_query.zig").BatchGetMetricDataQuery;
const MetricDataError = @import("metric_data_error.zig").MetricDataError;
const MetricDataResult = @import("metric_data_result.zig").MetricDataResult;

pub const BatchGetMetricDataInput = struct {
    /// A list of queries for metrics to be retrieved.
    queries: []const BatchGetMetricDataQuery,

    pub const json_field_names = .{
        .queries = "Queries",
    };
};

pub const BatchGetMetricDataOutput = struct {
    /// A list of `MetricDataError` encountered while processing your metric data
    /// batch request.
    errors: ?[]const MetricDataError = null,

    /// A list of successfully retrieved `MetricDataResult`.
    results: ?[]const MetricDataResult = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .results = "Results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetMetricDataInput, options: CallOptions) !BatchGetMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/metrics/batch";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Queries\":");
    try aws.json.writeValue(@TypeOf(input.queries), input.queries, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetMetricDataOutput {
    var result: BatchGetMetricDataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetMetricDataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
