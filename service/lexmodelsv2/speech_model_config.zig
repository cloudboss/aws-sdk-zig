const DeepgramSpeechModelConfig = @import("deepgram_speech_model_config.zig").DeepgramSpeechModelConfig;

/// Configuration settings that define which speech-to-text model to use for
/// processing speech input.
pub const SpeechModelConfig = struct {
    /// Configuration settings for using Deepgram as the speech-to-text provider.
    deepgram_config: ?DeepgramSpeechModelConfig,

    pub const json_field_names = .{
        .deepgram_config = "deepgramConfig",
    };
};
