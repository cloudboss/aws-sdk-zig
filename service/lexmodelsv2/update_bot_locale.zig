const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AudioFillerSettings = @import("audio_filler_settings.zig").AudioFillerSettings;
const GenerativeAISettings = @import("generative_ai_settings.zig").GenerativeAISettings;
const SpeechDetectionSensitivity = @import("speech_detection_sensitivity.zig").SpeechDetectionSensitivity;
const SpeechRecognitionSettings = @import("speech_recognition_settings.zig").SpeechRecognitionSettings;
const UnifiedSpeechSettings = @import("unified_speech_settings.zig").UnifiedSpeechSettings;
const VoiceSettings = @import("voice_settings.zig").VoiceSettings;
const BotLocaleStatus = @import("bot_locale_status.zig").BotLocaleStatus;

pub const UpdateBotLocaleInput = struct {
    /// Updated audio filler settings to apply to the bot locale. When
    /// enabled, requires `unifiedSpeechSettings` (speech-to-speech)
    /// to be configured on the bot locale.
    audio_filler_settings: ?AudioFillerSettings = null,

    /// The unique identifier of the bot that contains the locale.
    bot_id: []const u8,

    /// The version of the bot that contains the locale to be updated. The
    /// version can only be the `DRAFT` version.
    bot_version: []const u8,

    /// The new description of the locale.
    description: ?[]const u8 = null,

    /// Contains settings for generative AI features powered by Amazon Bedrock for
    /// your bot locale. Use this object to turn generative AI features on and off.
    /// Pricing
    /// may differ if you turn a feature on. For more information, see LINK.
    generative_ai_settings: ?GenerativeAISettings = null,

    /// The identifier of the language and locale to update. The string must
    /// match one of the supported locales. For more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// The new confidence threshold where Amazon Lex inserts the
    /// `AMAZON.FallbackIntent` and
    /// `AMAZON.KendraSearchIntent` intents in the list of
    /// possible intents for an utterance.
    nlu_intent_confidence_threshold: f64,

    /// The new sensitivity level for voice activity detection (VAD) in the bot
    /// locale. This setting helps optimize speech recognition accuracy by adjusting
    /// how the system responds to background noise during voice interactions.
    speech_detection_sensitivity: ?SpeechDetectionSensitivity = null,

    /// Updated speech-to-text settings to apply to the bot locale.
    speech_recognition_settings: ?SpeechRecognitionSettings = null,

    /// Updated unified speech settings to apply to the bot locale.
    unified_speech_settings: ?UnifiedSpeechSettings = null,

    /// The new Amazon Polly voice Amazon Lex should use for voice interaction with
    /// the
    /// user.
    voice_settings: ?VoiceSettings = null,

    pub const json_field_names = .{
        .audio_filler_settings = "audioFillerSettings",
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

pub const UpdateBotLocaleOutput = struct {
    /// The updated audio filler settings for the bot locale.
    audio_filler_settings: ?AudioFillerSettings = null,

    /// The identifier of the bot that contains the updated locale.
    bot_id: ?[]const u8 = null,

    /// The current status of the locale. When the bot status is
    /// `Built` the locale is ready for use.
    bot_locale_status: ?BotLocaleStatus = null,

    /// The version of the bot that contains the updated locale.
    bot_version: ?[]const u8 = null,

    /// A timestamp of the date and time that the locale was created.
    creation_date_time: ?i64 = null,

    /// The updated description of the locale.
    description: ?[]const u8 = null,

    /// If the `botLocaleStatus` is `Failed`, the
    /// `failureReasons` field lists the errors that occurred
    /// while building the bot.
    failure_reasons: ?[]const []const u8 = null,

    /// Contains settings for generative AI features powered by Amazon Bedrock for
    /// your bot locale.
    generative_ai_settings: ?GenerativeAISettings = null,

    /// A timestamp of the date and time that the locale was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The language and locale of the updated bot locale.
    locale_id: ?[]const u8 = null,

    /// The updated locale name for the locale.
    locale_name: ?[]const u8 = null,

    /// The updated confidence threshold for inserting the
    /// `AMAZON.FallbackIntent` and
    /// `AMAZON.KendraSearchIntent` intents in the list of
    /// possible intents for an utterance.
    nlu_intent_confidence_threshold: ?f64 = null,

    /// Recommended actions to take to resolve an error in the
    /// `failureReasons` field.
    recommended_actions: ?[]const []const u8 = null,

    /// The updated sensitivity level for voice activity detection (VAD) in the bot
    /// locale.
    speech_detection_sensitivity: ?SpeechDetectionSensitivity = null,

    /// The updated speech-to-text settings for the bot locale.
    speech_recognition_settings: ?SpeechRecognitionSettings = null,

    /// The updated unified speech settings for the bot locale.
    unified_speech_settings: ?UnifiedSpeechSettings = null,

    /// The updated Amazon Polly voice to use for voice interaction with the
    /// user.
    voice_settings: ?VoiceSettings = null,

    pub const json_field_names = .{
        .audio_filler_settings = "audioFillerSettings",
        .bot_id = "botId",
        .bot_locale_status = "botLocaleStatus",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .failure_reasons = "failureReasons",
        .generative_ai_settings = "generativeAISettings",
        .last_updated_date_time = "lastUpdatedDateTime",
        .locale_id = "localeId",
        .locale_name = "localeName",
        .nlu_intent_confidence_threshold = "nluIntentConfidenceThreshold",
        .recommended_actions = "recommendedActions",
        .speech_detection_sensitivity = "speechDetectionSensitivity",
        .speech_recognition_settings = "speechRecognitionSettings",
        .unified_speech_settings = "unifiedSpeechSettings",
        .voice_settings = "voiceSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBotLocaleInput, options: CallOptions) !UpdateBotLocaleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBotLocaleInput, config: *aws.Config) !aws.http.Request {
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

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.audio_filler_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"audioFillerSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBotLocaleOutput {
    var result: UpdateBotLocaleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBotLocaleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
