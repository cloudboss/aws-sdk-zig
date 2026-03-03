const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BotLocaleHistoryEvent = @import("bot_locale_history_event.zig").BotLocaleHistoryEvent;
const BotLocaleStatus = @import("bot_locale_status.zig").BotLocaleStatus;
const GenerativeAISettings = @import("generative_ai_settings.zig").GenerativeAISettings;
const SpeechDetectionSensitivity = @import("speech_detection_sensitivity.zig").SpeechDetectionSensitivity;
const SpeechRecognitionSettings = @import("speech_recognition_settings.zig").SpeechRecognitionSettings;
const UnifiedSpeechSettings = @import("unified_speech_settings.zig").UnifiedSpeechSettings;
const VoiceSettings = @import("voice_settings.zig").VoiceSettings;

pub const DescribeBotLocaleInput = struct {
    /// The identifier of the bot associated with the locale.
    bot_id: []const u8,

    /// The version of the bot associated with the
    /// locale.
    bot_version: []const u8,

    /// The unique identifier of the locale to describe. The string must
    /// match one of the supported locales. For more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub const DescribeBotLocaleOutput = struct {
    /// The identifier of the bot associated with the locale.
    bot_id: ?[]const u8 = null,

    /// History of changes, such as when a locale is used in an alias, that
    /// have taken place for the locale.
    bot_locale_history_events: ?[]const BotLocaleHistoryEvent = null,

    /// The status of the bot. If the status is `Failed`, the
    /// reasons for the failure are listed in the `failureReasons`
    /// field.
    bot_locale_status: ?BotLocaleStatus = null,

    /// The version of the bot associated with the
    /// locale.
    bot_version: ?[]const u8 = null,

    /// The date and time that the locale was created.
    creation_date_time: ?i64 = null,

    /// The description of the locale.
    description: ?[]const u8 = null,

    /// if `botLocaleStatus` is `Failed`, Amazon Lex
    /// explains why it failed to build the bot.
    failure_reasons: ?[]const []const u8 = null,

    /// Contains settings for Amazon Bedrock's generative AI features for your bot
    /// locale.
    generative_ai_settings: ?GenerativeAISettings = null,

    /// The number of intents defined for the locale.
    intents_count: ?i32 = null,

    /// The date and time that the locale was last submitted for
    /// building.
    last_build_submitted_date_time: ?i64 = null,

    /// The date and time that the locale was last updated.
    last_updated_date_time: ?i64 = null,

    /// The unique identifier of the described locale.
    locale_id: ?[]const u8 = null,

    /// The name of the locale.
    locale_name: ?[]const u8 = null,

    /// The confidence threshold where Amazon Lex inserts the
    /// `AMAZON.FallbackIntent` and
    /// `AMAZON.KendraSearchIntent` intents in the list of
    /// possible intents for an utterance.
    nlu_intent_confidence_threshold: ?f64 = null,

    /// Recommended actions to take to resolve an error in the
    /// `failureReasons` field.
    recommended_actions: ?[]const []const u8 = null,

    /// The number of slot types defined for the locale.
    slot_types_count: ?i32 = null,

    /// The sensitivity level for voice activity detection (VAD) configured for the
    /// bot locale.
    speech_detection_sensitivity: ?SpeechDetectionSensitivity = null,

    /// The speech-to-text settings configured for the bot locale.
    speech_recognition_settings: ?SpeechRecognitionSettings = null,

    /// The unified speech settings configured for the bot locale.
    unified_speech_settings: ?UnifiedSpeechSettings = null,

    /// The Amazon Polly voice Amazon Lex uses for voice interaction with the
    /// user.
    voice_settings: ?VoiceSettings = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_locale_history_events = "botLocaleHistoryEvents",
        .bot_locale_status = "botLocaleStatus",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .failure_reasons = "failureReasons",
        .generative_ai_settings = "generativeAISettings",
        .intents_count = "intentsCount",
        .last_build_submitted_date_time = "lastBuildSubmittedDateTime",
        .last_updated_date_time = "lastUpdatedDateTime",
        .locale_id = "localeId",
        .locale_name = "localeName",
        .nlu_intent_confidence_threshold = "nluIntentConfidenceThreshold",
        .recommended_actions = "recommendedActions",
        .slot_types_count = "slotTypesCount",
        .speech_detection_sensitivity = "speechDetectionSensitivity",
        .speech_recognition_settings = "speechRecognitionSettings",
        .unified_speech_settings = "unifiedSpeechSettings",
        .voice_settings = "voiceSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBotLocaleInput, options: CallOptions) !DescribeBotLocaleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelsv2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBotLocaleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBotLocaleOutput {
    var result: DescribeBotLocaleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeBotLocaleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
