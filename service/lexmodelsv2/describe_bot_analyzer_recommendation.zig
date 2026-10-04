const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotAnalyzerRecommendation = @import("bot_analyzer_recommendation.zig").BotAnalyzerRecommendation;
const BotAnalyzerStatus = @import("bot_analyzer_status.zig").BotAnalyzerStatus;

pub const DescribeBotAnalyzerRecommendationInput = struct {
    /// The unique identifier of the analysis request.
    bot_analyzer_request_id: []const u8,

    /// The unique identifier of the bot.
    bot_id: []const u8,

    /// The maximum number of recommendations to return in the response. The default
    /// is 5.
    max_results: ?i32 = null,

    /// If the response from a previous request was truncated, the `nextToken` value
    /// is used to retrieve the next page of recommendations.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_analyzer_request_id = "botAnalyzerRequestId",
        .bot_id = "botId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeBotAnalyzerRecommendationOutput = struct {
    /// A list of recommendations for optimizing your bot configuration. Each
    /// recommendation includes the issue location, priority, description, and
    /// proposed fix.
    bot_analyzer_recommendation_list: ?[]const BotAnalyzerRecommendation = null,

    /// The current status of the analysis.
    ///
    /// Valid Values: `Processing | Available | Failed | Stopping | Stopped`
    bot_analyzer_status: ?BotAnalyzerStatus = null,

    /// The unique identifier of the bot.
    bot_id: ?[]const u8 = null,

    /// The version of the bot that was analyzed.
    bot_version: ?[]const u8 = null,

    /// The date and time when the analysis was initiated.
    creation_date_time: ?i64 = null,

    /// The locale identifier of the bot locale that was analyzed.
    locale_id: ?[]const u8 = null,

    /// If the response is truncated, this token can be used in a subsequent request
    /// to retrieve the next page of recommendations.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_analyzer_recommendation_list = "botAnalyzerRecommendationList",
        .bot_analyzer_status = "botAnalyzerStatus",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .locale_id = "localeId",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBotAnalyzerRecommendationInput, options: CallOptions) !DescribeBotAnalyzerRecommendationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBotAnalyzerRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botanalyzer/describe/");
    try path_buf.appendSlice(allocator, input.bot_analyzer_request_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBotAnalyzerRecommendationOutput {
    const result: DescribeBotAnalyzerRecommendationOutput = try aws.json.parseJsonObject(
        DescribeBotAnalyzerRecommendationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
