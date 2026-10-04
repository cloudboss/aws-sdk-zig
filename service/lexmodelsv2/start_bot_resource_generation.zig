const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GenerationStatus = @import("generation_status.zig").GenerationStatus;

pub const StartBotResourceGenerationInput = struct {
    /// The unique identifier of the bot for which to generate intents and slot
    /// types.
    bot_id: []const u8,

    /// The version of the bot for which to generate intents and slot types.
    bot_version: []const u8,

    /// The prompt to generate intents and slot types for the bot locale. Your
    /// description should be both *detailed* and *precise* to help generate
    /// appropriate and sufficient intents for your bot. Include a list of actions
    /// to improve the intent creation process.
    generation_input_prompt: []const u8,

    /// The locale of the bot for which to generate intents and slot types.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .generation_input_prompt = "generationInputPrompt",
        .locale_id = "localeId",
    };
};

pub const StartBotResourceGenerationOutput = struct {
    /// The unique identifier of the bot for which the generation request was made.
    bot_id: ?[]const u8 = null,

    /// The version of the bot for which the generation request was made.
    bot_version: ?[]const u8 = null,

    /// The date and time at which the generation request was made.
    creation_date_time: ?i64 = null,

    /// The unique identifier of the generation request.
    generation_id: ?[]const u8 = null,

    /// The prompt that was used generate intents and slot types for the bot locale.
    generation_input_prompt: ?[]const u8 = null,

    /// The status of the generation request.
    generation_status: ?GenerationStatus = null,

    /// The locale of the bot for which the generation request was made.
    locale_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .generation_id = "generationId",
        .generation_input_prompt = "generationInputPrompt",
        .generation_status = "generationStatus",
        .locale_id = "localeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartBotResourceGenerationInput, options: CallOptions) !StartBotResourceGenerationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartBotResourceGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/startgeneration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"generationInputPrompt\":");
    try aws.json.writeValue(@TypeOf(input.generation_input_prompt), input.generation_input_prompt, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartBotResourceGenerationOutput {
    const result: StartBotResourceGenerationOutput = try aws.json.parseJsonObject(
        StartBotResourceGenerationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
