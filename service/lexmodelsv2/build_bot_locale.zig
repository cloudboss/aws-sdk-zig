const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotLocaleStatus = @import("bot_locale_status.zig").BotLocaleStatus;

pub const BuildBotLocaleInput = struct {
    /// The identifier of the bot to build. The identifier is returned in
    /// the response from the
    /// [CreateBot](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_CreateBot.html) operation.
    bot_id: []const u8,

    /// The version of the bot to build. This can only be the draft version
    /// of the bot.
    bot_version: []const u8,

    /// The identifier of the language and locale that the bot will be used
    /// in. The string must match one of the supported locales. All of the
    /// intents, slot types, and slots used in the bot must have the same
    /// locale. For more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub const BuildBotLocaleOutput = struct {
    /// The identifier of the specified bot.
    bot_id: ?[]const u8 = null,

    /// The bot's build status. When the status is
    /// `ReadyExpressTesting` you can test the bot using the
    /// utterances defined for the intents and slot types. When the status is
    /// `Built`, the bot is ready for use and can be tested using
    /// any utterance.
    bot_locale_status: ?BotLocaleStatus = null,

    /// The version of the bot that was built. This is only the draft
    /// version of the bot.
    bot_version: ?[]const u8 = null,

    /// A timestamp indicating the date and time that the bot was last built
    /// for this locale.
    last_build_submitted_date_time: ?i64 = null,

    /// The language and locale specified of where the bot can be
    /// used.
    locale_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_locale_status = "botLocaleStatus",
        .bot_version = "botVersion",
        .last_build_submitted_date_time = "lastBuildSubmittedDateTime",
        .locale_id = "localeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BuildBotLocaleInput, options: CallOptions) !BuildBotLocaleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BuildBotLocaleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BuildBotLocaleOutput {
    const result: BuildBotLocaleOutput = try aws.json.parseJsonObject(
        BuildBotLocaleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
