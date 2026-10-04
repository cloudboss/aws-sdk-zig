const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotRecommendationStatus = @import("bot_recommendation_status.zig").BotRecommendationStatus;

pub const StopBotRecommendationInput = struct {
    /// The unique identifier of the bot containing the bot
    /// recommendation to be stopped.
    bot_id: []const u8,

    /// The unique identifier of the bot recommendation to be
    /// stopped.
    bot_recommendation_id: []const u8,

    /// The version of the bot containing the bot recommendation.
    bot_version: []const u8,

    /// The identifier of the language and locale of the bot recommendation
    /// to stop. The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html)
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_recommendation_id = "botRecommendationId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub const StopBotRecommendationOutput = struct {
    /// The unique identifier of the bot containing the bot recommendation that
    /// is being stopped.
    bot_id: ?[]const u8 = null,

    /// The unique identifier of the bot recommendation that is being
    /// stopped.
    bot_recommendation_id: ?[]const u8 = null,

    /// The status of the bot recommendation. If the status is Failed,
    /// then the reasons for the failure are listed in the failureReasons field.
    bot_recommendation_status: ?BotRecommendationStatus = null,

    /// The version of the bot containing the recommendation that is being
    /// stopped.
    bot_version: ?[]const u8 = null,

    /// The identifier of the language and locale of the bot response
    /// to stop. The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html)
    locale_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_recommendation_id = "botRecommendationId",
        .bot_recommendation_status = "botRecommendationStatus",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopBotRecommendationInput, options: CallOptions) !StopBotRecommendationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopBotRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/botrecommendations/");
    try path_buf.appendSlice(allocator, input.bot_recommendation_id);
    try path_buf.appendSlice(allocator, "/stopbotrecommendation");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopBotRecommendationOutput {
    var result: StopBotRecommendationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StopBotRecommendationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
