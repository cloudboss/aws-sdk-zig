const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotLocaleStatus = @import("bot_locale_status.zig").BotLocaleStatus;

pub const DeleteBotLocaleInput = struct {
    /// The unique identifier of the bot that contains the locale.
    bot_id: []const u8,

    /// The version of the bot that contains the locale.
    bot_version: []const u8,

    /// The identifier of the language and locale that will be deleted. The
    /// string must match one of the supported locales. For more information,
    /// see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub const DeleteBotLocaleOutput = struct {
    /// The identifier of the bot that contained the deleted locale.
    bot_id: ?[]const u8 = null,

    /// The status of deleting the bot locale. The locale first enters the
    /// `Deleting` status. Once the locale is deleted it no
    /// longer appears in the list of locales for the bot.
    bot_locale_status: ?BotLocaleStatus = null,

    /// The version of the bot that contained the deleted locale.
    bot_version: ?[]const u8 = null,

    /// The language and locale of the deleted locale.
    locale_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_locale_status = "botLocaleStatus",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBotLocaleInput, options: CallOptions) !DeleteBotLocaleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBotLocaleInput, config: *aws.Config) !aws.http.Request {
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
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBotLocaleOutput {
    var result: DeleteBotLocaleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteBotLocaleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
