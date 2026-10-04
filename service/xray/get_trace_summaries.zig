const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SamplingStrategy = @import("sampling_strategy.zig").SamplingStrategy;
const TimeRangeType = @import("time_range_type.zig").TimeRangeType;
const TraceSummary = @import("trace_summary.zig").TraceSummary;

pub const GetTraceSummariesInput = struct {
    /// The end of the time frame for which to retrieve traces.
    end_time: i64,

    /// Specify a filter expression to retrieve trace summaries for services or
    /// requests that
    /// meet certain requirements.
    filter_expression: ?[]const u8 = null,

    /// Specify the pagination token returned by a previous request to retrieve the
    /// next page
    /// of results.
    next_token: ?[]const u8 = null,

    /// Set to `true` to get summaries for only a subset of available
    /// traces.
    sampling: ?bool = null,

    /// A parameter to indicate whether to enable sampling on trace summaries. Input
    /// parameters are Name and
    /// Value.
    sampling_strategy: ?SamplingStrategy = null,

    /// The start of the time frame for which to retrieve traces.
    start_time: i64,

    /// Query trace summaries by TraceId (trace start time), Event (trace update
    /// time), or Service (trace segment end time).
    time_range_type: ?TimeRangeType = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .filter_expression = "FilterExpression",
        .next_token = "NextToken",
        .sampling = "Sampling",
        .sampling_strategy = "SamplingStrategy",
        .start_time = "StartTime",
        .time_range_type = "TimeRangeType",
    };
};

pub const GetTraceSummariesOutput = struct {
    /// The start time of this page of results.
    approximate_time: ?i64 = null,

    /// If the requested time frame contained more than one page of results, you can
    /// use this token to retrieve the
    /// next page. The first page contains the most recent results, closest to the
    /// end of the time frame.
    next_token: ?[]const u8 = null,

    /// The total number of traces processed, including traces that did not match
    /// the specified
    /// filter expression.
    traces_processed_count: ?i64 = null,

    /// Trace IDs and annotations for traces that were found in the specified time
    /// frame.
    trace_summaries: ?[]const TraceSummary = null,

    pub const json_field_names = .{
        .approximate_time = "ApproximateTime",
        .next_token = "NextToken",
        .traces_processed_count = "TracesProcessedCount",
        .trace_summaries = "TraceSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTraceSummariesInput, options: CallOptions) !GetTraceSummariesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTraceSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/TraceSummaries";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (input.filter_expression) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterExpression\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sampling) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Sampling\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sampling_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SamplingStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
    has_prev = true;
    if (input.time_range_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TimeRangeType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTraceSummariesOutput {
    const result: GetTraceSummariesOutput = try aws.json.parseJsonObject(
        GetTraceSummariesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
