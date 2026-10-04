const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotAnalyzerStatus = @import("bot_analyzer_status.zig").BotAnalyzerStatus;

pub const StopBotAnalyzerInput = struct {
    /// The unique identifier of the analysis request to stop.
    bot_analyzer_request_id: []const u8,

    /// The unique identifier of the bot.
    bot_id: []const u8,

    pub const json_field_names = .{
        .bot_analyzer_request_id = "botAnalyzerRequestId",
        .bot_id = "botId",
    };
};

pub const StopBotAnalyzerOutput = struct {
    /// The unique identifier of the analysis request.
    bot_analyzer_request_id: ?[]const u8 = null,

    /// The updated status of the analysis. The status will be `Stopping` and will
    /// eventually transition to `Stopped`.
    ///
    /// Valid Values: `Processing | Available | Failed | Stopping | Stopped`
    bot_analyzer_status: ?BotAnalyzerStatus = null,

    /// The unique identifier of the bot.
    bot_id: ?[]const u8 = null,

    /// The version of the bot.
    bot_version: ?[]const u8 = null,

    /// The locale identifier of the bot locale.
    locale_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_analyzer_request_id = "botAnalyzerRequestId",
        .bot_analyzer_status = "botAnalyzerStatus",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopBotAnalyzerInput, options: CallOptions) !StopBotAnalyzerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopBotAnalyzerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botanalyzer/");
    try path_buf.appendSlice(allocator, input.bot_analyzer_request_id);
    try path_buf.appendSlice(allocator, "/stop");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopBotAnalyzerOutput {
    const result: StopBotAnalyzerOutput = try aws.json.parseJsonObject(
        StopBotAnalyzerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
