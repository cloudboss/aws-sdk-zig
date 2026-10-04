const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AudioFillerSettings = @import("audio_filler_settings.zig").AudioFillerSettings;
const GenerativeAISettings = @import("generative_ai_settings.zig").GenerativeAISettings;
const SpeakerDiarizationSettings = @import("speaker_diarization_settings.zig").SpeakerDiarizationSettings;
const SpeechDetectionSensitivity = @import("speech_detection_sensitivity.zig").SpeechDetectionSensitivity;
const SpeechRecognitionSettings = @import("speech_recognition_settings.zig").SpeechRecognitionSettings;
const UnifiedSpeechSettings = @import("unified_speech_settings.zig").UnifiedSpeechSettings;
const VoiceSettings = @import("voice_settings.zig").VoiceSettings;
const BotLocaleStatus = @import("bot_locale_status.zig").BotLocaleStatus;

pub const CreateBotLocaleInput = struct {
    /// Audio filler settings to configure for the new bot locale. When
    /// enabled, Amazon Lex plays a brief background audio filler during
    /// speech-to-speech interactions to mask processing delays. Requires
    /// `unifiedSpeechSettings` (speech-to-speech) to be configured
    /// on the bot locale.
    audio_filler_settings: ?AudioFillerSettings = null,

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

    /// The speaker diarization settings to configure for the new bot
    /// locale. When enabled, Amazon Lex restricts speech detection to the primary
    /// (loudest) speaker during streaming audio conversations.
    speaker_diarization_settings: ?SpeakerDiarizationSettings = null,

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
        .audio_filler_settings = "audioFillerSettings",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .description = "description",
        .generative_ai_settings = "generativeAISettings",
        .locale_id = "localeId",
        .nlu_intent_confidence_threshold = "nluIntentConfidenceThreshold",
        .speaker_diarization_settings = "speakerDiarizationSettings",
        .speech_detection_sensitivity = "speechDetectionSensitivity",
        .speech_recognition_settings = "speechRecognitionSettings",
        .unified_speech_settings = "unifiedSpeechSettings",
        .voice_settings = "voiceSettings",
    };
};

pub const CreateBotLocaleOutput = struct {
    /// The audio filler settings configured for the created bot locale.
    audio_filler_settings: ?AudioFillerSettings = null,

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

    /// The speaker diarization settings configured for the created bot
    /// locale.
    speaker_diarization_settings: ?SpeakerDiarizationSettings = null,

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
        .audio_filler_settings = "audioFillerSettings",
        .bot_id = "botId",
        .bot_locale_status = "botLocaleStatus",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .generative_ai_settings = "generativeAISettings",
        .locale_id = "localeId",
        .locale_name = "localeName",
        .nlu_intent_confidence_threshold = "nluIntentConfidenceThreshold",
        .speaker_diarization_settings = "speakerDiarizationSettings",
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBotLocaleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales");
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
    try body_buf.appendSlice(allocator, "\"localeId\":");
    try aws.json.writeValue(@TypeOf(input.locale_id), input.locale_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"nluIntentConfidenceThreshold\":");
    try aws.json.writeValue(@TypeOf(input.nlu_intent_confidence_threshold), input.nlu_intent_confidence_threshold, allocator, &body_buf);
    has_prev = true;
    if (input.speaker_diarization_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"speakerDiarizationSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBotLocaleOutput {
    const result: CreateBotLocaleOutput = try aws.json.parseJsonObject(
        CreateBotLocaleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
