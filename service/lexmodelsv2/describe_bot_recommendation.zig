const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotRecommendationResults = @import("bot_recommendation_results.zig").BotRecommendationResults;
const BotRecommendationStatus = @import("bot_recommendation_status.zig").BotRecommendationStatus;
const EncryptionSetting = @import("encryption_setting.zig").EncryptionSetting;
const TranscriptSourceSetting = @import("transcript_source_setting.zig").TranscriptSourceSetting;

pub const DescribeBotRecommendationInput = struct {
    /// The unique identifier of the bot associated with the bot
    /// recommendation.
    bot_id: []const u8,

    /// The identifier of the bot recommendation to describe.
    bot_recommendation_id: []const u8,

    /// The version of the bot associated with the bot
    /// recommendation.
    bot_version: []const u8,

    /// The identifier of the language and locale of the bot recommendation
    /// to describe. The string must match one of the supported locales. For
    /// more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_recommendation_id = "botRecommendationId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub const DescribeBotRecommendationOutput = struct {
    /// The identifier of the bot associated with the bot
    /// recommendation.
    bot_id: ?[]const u8 = null,

    /// The identifier of the bot recommendation being described.
    bot_recommendation_id: ?[]const u8 = null,

    /// The object representing the URL of the bot definition, the URL of
    /// the associated transcript and a statistical summary of the bot
    /// recommendation results.
    bot_recommendation_results: ?BotRecommendationResults = null,

    /// The status of the bot recommendation. If the status is Failed, then
    /// the reasons for the failure are listed in the failureReasons field.
    bot_recommendation_status: ?BotRecommendationStatus = null,

    /// The version of the bot associated with the bot
    /// recommendation.
    bot_version: ?[]const u8 = null,

    /// The date and time that the bot recommendation was created.
    creation_date_time: ?i64 = null,

    /// The object representing the passwords that were used to encrypt the
    /// data related to the bot recommendation results, as well as the KMS key
    /// ARN used to encrypt the associated metadata.
    encryption_setting: ?EncryptionSetting = null,

    /// If botRecommendationStatus is Failed, Amazon Lex explains why.
    failure_reasons: ?[]const []const u8 = null,

    /// The date and time that the bot recommendation was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The identifier of the language and locale of the bot recommendation
    /// to describe.
    locale_id: ?[]const u8 = null,

    /// The object representing the Amazon S3 bucket containing the transcript,
    /// as well as the associated metadata.
    transcript_source_setting: ?TranscriptSourceSetting = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_recommendation_id = "botRecommendationId",
        .bot_recommendation_results = "botRecommendationResults",
        .bot_recommendation_status = "botRecommendationStatus",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .encryption_setting = "encryptionSetting",
        .failure_reasons = "failureReasons",
        .last_updated_date_time = "lastUpdatedDateTime",
        .locale_id = "localeId",
        .transcript_source_setting = "transcriptSourceSetting",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBotRecommendationInput, options: CallOptions) !DescribeBotRecommendationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBotRecommendationInput, config: *aws.Config) !aws.http.Request {
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBotRecommendationOutput {
    var result: DescribeBotRecommendationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeBotRecommendationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
