const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InsightState = @import("insight_state.zig").InsightState;
const InsightSummary = @import("insight_summary.zig").InsightSummary;

pub const GetInsightSummariesInput = struct {
    /// The end of the time frame in which the insights ended. The end time can't be
    /// more than 30 days old.
    end_time: i64,

    /// The Amazon Resource Name (ARN) of the group. Required if the GroupName isn't
    /// provided.
    group_arn: ?[]const u8 = null,

    /// The name of the group. Required if the GroupARN isn't provided.
    group_name: ?[]const u8 = null,

    /// The maximum number of results to display.
    max_results: ?i32 = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// The beginning of the time frame in which the insights started. The start
    /// time can't be more than 30 days
    /// old.
    start_time: i64,

    /// The list of insight states.
    states: ?[]const InsightState = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .group_arn = "GroupARN",
        .group_name = "GroupName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_time = "StartTime",
        .states = "States",
    };
};

pub const GetInsightSummariesOutput = struct {
    /// The summary of each insight within the group matching the provided filters.
    /// The summary
    /// contains the InsightID, start and end time, the root cause service, the root
    /// cause and
    /// client impact statistics, the top anomalous services, and the status of the
    /// insight.
    insight_summaries: ?[]const InsightSummary = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .insight_summaries = "InsightSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInsightSummariesInput, options: CallOptions) !GetInsightSummariesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInsightSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/InsightSummaries";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (input.group_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
    has_prev = true;
    if (input.states) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"States\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInsightSummariesOutput {
    var result: GetInsightSummariesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetInsightSummariesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
