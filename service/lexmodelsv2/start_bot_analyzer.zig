const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisScope = @import("analysis_scope.zig").AnalysisScope;
const BotAnalyzerStatus = @import("bot_analyzer_status.zig").BotAnalyzerStatus;

pub const StartBotAnalyzerInput = struct {
    /// The scope of analysis to perform. Currently only `BotLocale` scope is
    /// supported.
    ///
    /// Valid Values: `BotLocale`
    analysis_scope: AnalysisScope,

    /// The unique identifier of the bot to analyze.
    bot_id: []const u8,

    /// The version of the bot to analyze. Defaults to `DRAFT` if not specified.
    bot_version: ?[]const u8 = null,

    /// The locale identifier for the bot locale to analyze. Required when
    /// `analysisScope` is `BotLocale`.
    locale_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_scope = "analysisScope",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub const StartBotAnalyzerOutput = struct {
    /// A unique identifier for this analysis request. Use this identifier to check
    /// the status and retrieve results.
    bot_analyzer_request_id: ?[]const u8 = null,

    /// The current status of the analysis. The initial status is `Processing`.
    ///
    /// Valid Values: `Processing | Available | Failed | Stopping | Stopped`
    bot_analyzer_status: ?BotAnalyzerStatus = null,

    /// The unique identifier of the bot being analyzed.
    bot_id: ?[]const u8 = null,

    /// The version of the bot being analyzed.
    bot_version: ?[]const u8 = null,

    /// The date and time when the analysis was initiated.
    creation_date_time: ?i64 = null,

    /// The locale identifier of the bot locale being analyzed.
    locale_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_analyzer_request_id = "botAnalyzerRequestId",
        .bot_analyzer_status = "botAnalyzerStatus",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .locale_id = "localeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartBotAnalyzerInput, options: CallOptions) !StartBotAnalyzerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartBotAnalyzerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botanalyzer");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analysisScope\":");
    try aws.json.writeValue(@TypeOf(input.analysis_scope), input.analysis_scope, allocator, &body_buf);
    has_prev = true;
    if (input.bot_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.locale_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"localeId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartBotAnalyzerOutput {
    const result: StartBotAnalyzerOutput = try aws.json.parseJsonObject(
        StartBotAnalyzerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
