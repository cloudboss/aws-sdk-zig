const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const GenerativeAISettings = @import("generative_ai_settings.zig").GenerativeAISettings;
const SpeechDetectionSensitivity = @import("speech_detection_sensitivity.zig").SpeechDetectionSensitivity;
const SpeechRecognitionSettings = @import("speech_recognition_settings.zig").SpeechRecognitionSettings;
const UnifiedSpeechSettings = @import("unified_speech_settings.zig").UnifiedSpeechSettings;
const VoiceSettings = @import("voice_settings.zig").VoiceSettings;
const BotLocaleStatus = @import("bot_locale_status.zig").BotLocaleStatus;

pub const CreateBotLocaleInput = struct {
    /// The identifier of the bot to create the locale for.
    bot_id: []const u8,

    /// The version of the bot to create the locale for. This can only be
    /// the draft version of the bot.
    bot_version: []const u8,

    /// A description of the bot locale. Use this to help identify the bot
    /// locale in lists.
    description: ?[]const u8 = null,

    generative_ai_settings: ?GenerativeAISettings = null,

    /// The identifier of the language and locale that the bot will be used
    /// in. The string must match one of the supported locales. All of the
    /// intents, slot types, and slots used in the bot must have the same
    /// locale. For more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// Determines the threshold where Amazon Lex will insert the
    /// `AMAZON.FallbackIntent`,
    /// `AMAZON.KendraSearchIntent`, or both when returning
    /// alternative intents. `AMAZON.FallbackIntent` and
    /// `AMAZON.KendraSearchIntent` are only inserted if they are
    /// configured for the bot.
    ///
    /// For example, suppose a bot is configured with the confidence
    /// threshold of 0.80 and the `AMAZON.FallbackIntent`. Amazon Lex
    /// returns three alternative intents with the following confidence scores:
    /// IntentA (0.70), IntentB (0.60), IntentC (0.50). The response from the
    /// `RecognizeText` operation would be:
    ///
    /// * AMAZON.FallbackIntent
    ///
    /// * IntentA
    ///
    /// * IntentB
    ///
    /// * IntentC
    nlu_intent_confidence_threshold: f64,

    /// The sensitivity level for voice activity detection (VAD) in the bot locale.
    /// This setting helps optimize speech recognition accuracy by adjusting how the
    /// system responds to background noise during voice interactions.
    speech_detection_sensitivity: ?SpeechDetectionSensitivity = null,

    /// Speech-to-text settings to configure for the new bot locale.
    speech_recognition_settings: ?SpeechRecognitionSettings = null,

    /// Unified speech settings to configure for the new bot locale.
    unified_speech_settings: ?UnifiedSpeechSettings = null,

    /// The Amazon Polly voice ID that Amazon Lex uses for voice interaction with
    /// the
    /// user.
    voice_settings: ?VoiceSettings = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .description = "description",
        .generative_ai_settings = "generativeAISettings",
        .locale_id = "localeId",
        .nlu_intent_confidence_threshold = "nluIntentConfidenceThreshold",
        .speech_detection_sensitivity = "speechDetectionSensitivity",
        .speech_recognition_settings = "speechRecognitionSettings",
        .unified_speech_settings = "unifiedSpeechSettings",
        .voice_settings = "voiceSettings",
    };
};

pub const CreateBotLocaleOutput = struct {
    /// The specified bot identifier.
    bot_id: ?[]const u8 = null,

    /// The status of the bot.
    ///
    /// When the status is `Creating` the bot locale is being
    /// configured. When the status is `Building` Amazon Lex is building
    /// the bot for testing and use.
    ///
    /// If the status of the bot is `ReadyExpressTesting`, you
    /// can test the bot using the exact utterances specified in the bots'
    /// intents. When the bot is ready for full testing or to run, the status
    /// is `Built`.
    ///
    /// If there was a problem with building the bot, the status is
    /// `Failed`. If the bot was saved but not built, the status
    /// is `NotBuilt`.
    bot_locale_status: ?BotLocaleStatus = null,

    /// The specified bot version.
    bot_version: ?[]const u8 = null,

    /// A timestamp specifying the date and time that the bot locale was
    /// created.
    creation_date_time: ?i64 = null,

    /// The specified description of the bot locale.
    description: ?[]const u8 = null,

    generative_ai_settings: ?GenerativeAISettings = null,

    /// The specified locale identifier.
    locale_id: ?[]const u8 = null,

    /// The specified locale name.
    locale_name: ?[]const u8 = null,

    /// The specified confidence threshold for inserting the
    /// `AMAZON.FallbackIntent` and
    /// `AMAZON.KendraSearchIntent` intents.
    nlu_intent_confidence_threshold: ?f64 = null,

    /// The sensitivity level for voice activity detection (VAD) that was specified
    /// for the bot locale.
    speech_detection_sensitivity: ?SpeechDetectionSensitivity = null,

    /// The speech-to-text settings configured for the created bot locale.
    speech_recognition_settings: ?SpeechRecognitionSettings = null,

    /// The unified speech settings configured for the created bot locale.
    unified_speech_settings: ?UnifiedSpeechSettings = null,

    /// The Amazon Polly voice ID that Amazon Lex uses for voice interaction with
    /// the
    /// user.
    voice_settings: ?VoiceSettings = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_locale_status = "botLocaleStatus",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .generative_ai_settings = "generativeAISettings",
        .locale_id = "localeId",
        .locale_name = "localeName",
        .nlu_intent_confidence_threshold = "nluIntentConfidenceThreshold",
        .speech_detection_sensitivity = "speechDetectionSensitivity",
        .speech_recognition_settings = "speechRecognitionSettings",
        .unified_speech_settings = "unifiedSpeechSettings",
        .voice_settings = "voiceSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBotLocaleInput, options: CallOptions) !CreateBotLocaleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lex");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBotLocaleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.generative_ai_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"generativeAISettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"localeId\":");
    try aws.json.writeValue(@TypeOf(input.locale_id), input.locale_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"nluIntentConfidenceThreshold\":");
    try aws.json.writeValue(@TypeOf(input.nlu_intent_confidence_threshold), input.nlu_intent_confidence_threshold, allocator, &body_buf);
    has_prev = true;
    if (input.speech_detection_sensitivity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"speechDetectionSensitivity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.speech_recognition_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"speechRecognitionSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.unified_speech_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"unifiedSpeechSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.voice_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"voiceSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBotLocaleOutput {
    var result: CreateBotLocaleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBotLocaleOutput, body, allocator);
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
