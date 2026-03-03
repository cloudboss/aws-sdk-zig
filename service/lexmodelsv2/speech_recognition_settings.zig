const SpeechModelConfig = @import("speech_model_config.zig").SpeechModelConfig;
const SpeechModelPreference = @import("speech_model_preference.zig").SpeechModelPreference;

/// Settings that control how Amazon Lex processes and recognizes speech input
/// from users.
pub const SpeechRecognitionSettings = struct {
    /// Configuration settings for the selected speech-to-text model.
    speech_model_config: ?SpeechModelConfig = null,

    /// The speech-to-text model to use.
    speech_model_preference: ?SpeechModelPreference = null,

    pub const json_field_names = .{
        .speech_model_config = "speechModelConfig",
        .speech_model_preference = "speechModelPreference",
    };
};
