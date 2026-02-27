const AudioRecognitionStrategy = @import("audio_recognition_strategy.zig").AudioRecognitionStrategy;

/// Provides settings that enable advanced recognition settings for slot values.
pub const AdvancedRecognitionSetting = struct {
    /// Enables using the slot values as a custom vocabulary for recognizing user
    /// utterances.
    audio_recognition_strategy: ?AudioRecognitionStrategy,

    pub const json_field_names = .{
        .audio_recognition_strategy = "audioRecognitionStrategy",
    };
};
