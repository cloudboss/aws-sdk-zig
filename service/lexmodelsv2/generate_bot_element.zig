const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SampleUtterance = @import("sample_utterance.zig").SampleUtterance;

pub const GenerateBotElementInput = struct {
    /// The bot unique Id for the bot request to generate utterances.
    bot_id: []const u8,

    /// The bot version for the bot request to generate utterances.
    bot_version: []const u8,

    /// The intent unique Id for the bot request to generate utterances.
    intent_id: []const u8,

    /// The unique locale Id for the bot request to generate utterances.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .intent_id = "intentId",
        .locale_id = "localeId",
    };
};

pub const GenerateBotElementOutput = struct {
    /// The unique bot Id for the bot which received the response.
    bot_id: ?[]const u8 = null,

    /// The unique bot version for the bot which received the response.
    bot_version: ?[]const u8 = null,

    /// The unique intent Id for the bot which received the response.
    intent_id: ?[]const u8 = null,

    /// The unique locale Id for the bot which received the response.
    locale_id: ?[]const u8 = null,

    /// The sample utterances for the bot which received the response.
    sample_utterances: ?[]const SampleUtterance = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .intent_id = "intentId",
        .locale_id = "localeId",
        .sample_utterances = "sampleUtterances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateBotElementInput, options: CallOptions) !GenerateBotElementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateBotElementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/generate");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"intentId\":");
    try aws.json.writeValue(@TypeOf(input.intent_id), input.intent_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateBotElementOutput {
    const result: GenerateBotElementOutput = try aws.json.parseJsonObject(
        GenerateBotElementOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
