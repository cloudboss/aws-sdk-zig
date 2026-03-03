const SpeechDetectionSensitivity = @import("speech_detection_sensitivity.zig").SpeechDetectionSensitivity;
const SpeechRecognitionSettings = @import("speech_recognition_settings.zig").SpeechRecognitionSettings;
const UnifiedSpeechSettings = @import("unified_speech_settings.zig").UnifiedSpeechSettings;
const VoiceSettings = @import("voice_settings.zig").VoiceSettings;

/// Provides the bot locale parameters required for importing a bot
/// locale.
pub const BotLocaleImportSpecification = struct {
    /// The identifier of the bot to import the locale to.
    bot_id: []const u8,

    /// The version of the bot to import the locale to. This can only be the
    /// `DRAFT` version of the bot.
    bot_version: []const u8,

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
    /// threshold of 0.80 and the `AMAZON.FallbackIntent`. Amazon
    /// Lex returns three alternative intents with the following confidence
    /// scores: IntentA (0.70), IntentB (0.60), IntentC (0.50). The response
    /// from the `PostText` operation would be:
    ///
    /// * `AMAZON.FallbackIntent`
    ///
    /// * `IntentA`
    ///
    /// * `IntentB`
    ///
    /// * `IntentC`
    nlu_intent_confidence_threshold: ?f64 = null,

    /// The sensitivity level for voice activity detection (VAD) in the bot locale.
    /// This setting helps optimize speech recognition accuracy by adjusting how the
    /// system responds to background noise during voice interactions.
    speech_detection_sensitivity: ?SpeechDetectionSensitivity = null,

    /// Speech-to-text settings to apply when importing the bot locale
    /// configuration.
    speech_recognition_settings: ?SpeechRecognitionSettings = null,

    /// Unified speech settings to apply when importing the bot locale
    /// configuration.
    unified_speech_settings: ?UnifiedSpeechSettings = null,

    voice_settings: ?VoiceSettings = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
        .nlu_intent_confidence_threshold = "nluIntentConfidenceThreshold",
        .speech_detection_sensitivity = "speechDetectionSensitivity",
        .speech_recognition_settings = "speechRecognitionSettings",
        .unified_speech_settings = "unifiedSpeechSettings",
        .voice_settings = "voiceSettings",
    };
};
