const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SamplingStatisticSummary = @import("sampling_statistic_summary.zig").SamplingStatisticSummary;

pub const GetSamplingStatisticSummariesInput = struct {
    /// Pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
    };
};

pub const GetSamplingStatisticSummariesOutput = struct {
    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// Information about the number of requests instrumented for each sampling
    /// rule.
    sampling_statistic_summaries: ?[]const SamplingStatisticSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .sampling_statistic_summaries = "SamplingStatisticSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSamplingStatisticSummariesInput, options: CallOptions) !GetSamplingStatisticSummariesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSamplingStatisticSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/SamplingStatisticSummaries";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSamplingStatisticSummariesOutput {
    const result: GetSamplingStatisticSummariesOutput = try aws.json.parseJsonObject(
        GetSamplingStatisticSummariesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
