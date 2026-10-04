const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalyticsBinBySpecification = @import("analytics_bin_by_specification.zig").AnalyticsBinBySpecification;
const AnalyticsIntentFilter = @import("analytics_intent_filter.zig").AnalyticsIntentFilter;
const AnalyticsIntentGroupBySpecification = @import("analytics_intent_group_by_specification.zig").AnalyticsIntentGroupBySpecification;
const AnalyticsIntentMetric = @import("analytics_intent_metric.zig").AnalyticsIntentMetric;
const AnalyticsIntentResult = @import("analytics_intent_result.zig").AnalyticsIntentResult;

pub const ListIntentMetricsInput = struct {
    /// A list of objects, each of which contains specifications for organizing the
    /// results by time.
    bin_by: ?[]const AnalyticsBinBySpecification = null,

    /// The identifier for the bot for which you want to retrieve intent metrics.
    bot_id: []const u8,

    /// The date and time that marks the end of the range of time for which you want
    /// to see intent metrics.
    end_date_time: i64,

    /// A list of objects, each of which describes a condition by which you want to
    /// filter the results.
    filters: ?[]const AnalyticsIntentFilter = null,

    /// A list of objects, each of which specifies how to group the results. You can
    /// group by the following criteria:
    ///
    /// * `IntentName` – The name of the intent.
    ///
    /// * `IntentEndState` – The final state of the intent. The possible end states
    ///   are detailed in [Key
    ///   definitions](https://docs.aws.amazon.com/analytics-key-definitions-intents) in the user guide.
    group_by: ?[]const AnalyticsIntentGroupBySpecification = null,

    /// The maximum number of results to return in each page of results. If there
    /// are fewer results than the maximum page size, only the actual number of
    /// results are returned.
    max_results: ?i32 = null,

    /// A list of objects, each of which contains a metric you want to list, the
    /// statistic for the metric you want to return, and the order by which to
    /// organize the results.
    metrics: []const AnalyticsIntentMetric,

    /// If the response from the ListIntentMetrics operation contains more results
    /// than specified in the maxResults parameter, a token is returned in the
    /// response.
    ///
    /// Use the returned token in the nextToken parameter of a ListIntentMetrics
    /// request to return the next page of results. For a complete set of results,
    /// call the ListIntentMetrics operation until the nextToken returned in the
    /// response is null.
    next_token: ?[]const u8 = null,

    /// The timestamp that marks the beginning of the range of time for which you
    /// want to see intent metrics.
    start_date_time: i64,

    pub const json_field_names = .{
        .bin_by = "binBy",
        .bot_id = "botId",
        .end_date_time = "endDateTime",
        .filters = "filters",
        .group_by = "groupBy",
        .max_results = "maxResults",
        .metrics = "metrics",
        .next_token = "nextToken",
        .start_date_time = "startDateTime",
    };
};

pub const ListIntentMetricsOutput = struct {
    /// The identifier for the bot for which you retrieved intent metrics.
    bot_id: ?[]const u8 = null,

    /// If the response from the ListIntentMetrics operation contains more results
    /// than specified in the maxResults parameter, a token is returned in the
    /// response.
    ///
    /// Use the returned token in the nextToken parameter of a ListIntentMetrics
    /// request to return the next page of results. For a complete set of results,
    /// call the ListIntentMetrics operation until the nextToken returned in the
    /// response is null.
    next_token: ?[]const u8 = null,

    /// The results for the intent metrics.
    results: ?[]const AnalyticsIntentResult = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .next_token = "nextToken",
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIntentMetricsInput, options: CallOptions) !ListIntentMetricsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIntentMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/analytics/intentmetrics");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bin_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"binBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.group_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"groupBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"metrics\":");
    try aws.json.writeValue(@TypeOf(input.metrics), input.metrics, allocator, &body_buf);
    has_prev = true;
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIntentMetricsOutput {
    const result: ListIntentMetricsOutput = try aws.json.parseJsonObject(
        ListIntentMetricsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
