const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GenerationStatus = @import("generation_status.zig").GenerationStatus;

pub const DescribeBotResourceGenerationInput = struct {
    /// The unique identifier of the bot for which to return the generation details.
    bot_id: []const u8,

    /// The version of the bot for which to return the generation details.
    bot_version: []const u8,

    /// The unique identifier of the generation request for which to
    /// return the generation details.
    generation_id: []const u8,

    /// The locale of the bot for which to return the generation details.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .generation_id = "generationId",
        .locale_id = "localeId",
    };
};

pub const DescribeBotResourceGenerationOutput = struct {
    /// The unique identifier of the bot for which the generation request was
    /// made.
    bot_id: ?[]const u8 = null,

    /// The version of the bot for which the generation request was made.
    bot_version: ?[]const u8 = null,

    /// The date and time at which the item was generated.
    creation_date_time: ?i64 = null,

    /// A list of reasons why the generation of bot resources through natural
    /// language description failed.
    failure_reasons: ?[]const []const u8 = null,

    /// The Amazon S3 location of the generated bot locale configuration.
    generated_bot_locale_url: ?[]const u8 = null,

    /// The generation ID for which to return the generation details.
    generation_id: ?[]const u8 = null,

    /// The prompt used in the generation request.
    generation_input_prompt: ?[]const u8 = null,

    /// The status of the generation request.
    generation_status: ?GenerationStatus = null,

    /// The date and time at which the generated item was updated.
    last_updated_date_time: ?i64 = null,

    /// The locale of the bot for which the generation request was made.
    locale_id: ?[]const u8 = null,

    /// The ARN of the model used to generate the bot resources.
    model_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .failure_reasons = "failureReasons",
        .generated_bot_locale_url = "generatedBotLocaleUrl",
        .generation_id = "generationId",
        .generation_input_prompt = "generationInputPrompt",
        .generation_status = "generationStatus",
        .last_updated_date_time = "lastUpdatedDateTime",
        .locale_id = "localeId",
        .model_arn = "modelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBotResourceGenerationInput, options: CallOptions) !DescribeBotResourceGenerationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBotResourceGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/generations/");
    try path_buf.appendSlice(allocator, input.generation_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBotResourceGenerationOutput {
    const result: DescribeBotResourceGenerationOutput = try aws.json.parseJsonObject(
        DescribeBotResourceGenerationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
