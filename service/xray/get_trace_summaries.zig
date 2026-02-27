const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTraceSummariesInput, options: Options) !GetTraceSummariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "xray");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetTraceSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/TraceSummaries";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, alloc, &body_buf);
    has_prev = true;
    if (input.filter_expression) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"FilterExpression\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sampling) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Sampling\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sampling_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SamplingStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, alloc, &body_buf);
    has_prev = true;
    if (input.time_range_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TimeRangeType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetTraceSummariesOutput {
    var result: GetTraceSummariesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTraceSummariesOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InvalidPolicyRevisionIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_revision_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LockoutPreventionException")) {
        return .{ .arena = arena, .kind = .{ .lockout_prevention_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyCountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_count_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicySizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuleLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .rule_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
