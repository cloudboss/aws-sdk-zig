const LanguageCode = @import("language_code.zig").LanguageCode;
const Gender = @import("gender.zig").Gender;
const VoiceId = @import("voice_id.zig").VoiceId;
const Engine = @import("engine.zig").Engine;

/// Description of the voice.
pub const Voice = struct {
    /// Additional codes for languages available for the specified voice in
    /// addition to its default language.
    ///
    /// For example, the default language for Aditi is Indian English (en-IN)
    /// because it was first used for that language. Since Aditi is bilingual and
    /// fluent in both Indian English and Hindi, this parameter would show the
    /// code `hi-IN`.
    additional_language_codes: ?[]const LanguageCode,

    /// Gender of the voice.
    gender: ?Gender,

    /// Amazon Polly assigned voice ID. This is the ID that you specify when
    /// calling the `SynthesizeSpeech` operation.
    id: ?VoiceId,

    /// Language code of the voice.
    language_code: ?LanguageCode,

    /// Human readable name of the language in English.
    language_name: ?[]const u8,

    /// Name of the voice (for example, Salli, Kendra, etc.). This provides
    /// a human readable voice name that you might display in your
    /// application.
    name: ?[]const u8,

    /// Specifies which engines (`standard`, `neural`,
    /// `long-form` or `generative`) are supported by a given voice.
    supported_engines: ?[]const Engine,

    pub const json_field_names = .{
        .additional_language_codes = "AdditionalLanguageCodes",
        .gender = "Gender",
        .id = "Id",
        .language_code = "LanguageCode",
        .language_name = "LanguageName",
        .name = "Name",
        .supported_engines = "SupportedEngines",
    };
};
