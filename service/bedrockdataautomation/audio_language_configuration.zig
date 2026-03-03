const AudioGenerativeOutputLanguage = @import("audio_generative_output_language.zig").AudioGenerativeOutputLanguage;
const Language = @import("language.zig").Language;

/// Optional configuration for audio language settings
pub const AudioLanguageConfiguration = struct {
    generative_output_language: ?AudioGenerativeOutputLanguage = null,

    /// Enable multiple language identification in audio
    identify_multiple_languages: ?bool = null,

    input_languages: ?[]const Language = null,

    pub const json_field_names = .{
        .generative_output_language = "generativeOutputLanguage",
        .identify_multiple_languages = "identifyMultipleLanguages",
        .input_languages = "inputLanguages",
    };
};
