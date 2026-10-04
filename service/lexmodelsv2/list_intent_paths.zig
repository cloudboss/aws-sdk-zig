const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalyticsPathFilter = @import("analytics_path_filter.zig").AnalyticsPathFilter;
const AnalyticsIntentNodeSummary = @import("analytics_intent_node_summary.zig").AnalyticsIntentNodeSummary;

pub const ListIntentPathsInput = struct {
    /// The identifier for the bot for which you want to retrieve intent path
    /// metrics.
    bot_id: []const u8,

    /// The date and time that marks the end of the range of time for which you want
    /// to see intent path metrics.
    end_date_time: i64,

    /// A list of objects, each describes a condition by which you want to filter
    /// the results.
    filters: ?[]const AnalyticsPathFilter = null,

    /// The intent path for which you want to retrieve metrics. Use a forward slash
    /// to separate intents in the path. For example:
    ///
    /// * /BookCar
    ///
    /// * /BookCar/BookHotel
    ///
    /// * /BookHotel/BookCar
    intent_path: []const u8,

    /// The date and time that marks the beginning of the range of time for which
    /// you want to see intent path metrics.
    start_date_time: i64,

    pub const json_field_names = .{
        .bot_id = "botId",
        .end_date_time = "endDateTime",
        .filters = "filters",
        .intent_path = "intentPath",
        .start_date_time = "startDateTime",
    };
};

pub const ListIntentPathsOutput = struct {
    /// A list of objects, each of which contains information about a node in the
    /// intent path for which you requested metrics.
    node_summaries: ?[]const AnalyticsIntentNodeSummary = null,

    pub const json_field_names = .{
        .node_summaries = "nodeSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIntentPathsInput, options: CallOptions) !ListIntentPathsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIntentPathsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/analytics/intentpaths");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"endDateTime\":");
    try aws.json.writeValue(@TypeOf(input.end_date_time), input.end_date_time, allocator, &body_buf);
    has_prev = true;
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"intentPath\":");
    try aws.json.writeValue(@TypeOf(input.intent_path), input.intent_path, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"startDateTime\":");
    try aws.json.writeValue(@TypeOf(input.start_date_time), input.start_date_time, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIntentPathsOutput {
    var result: ListIntentPathsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListIntentPathsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
