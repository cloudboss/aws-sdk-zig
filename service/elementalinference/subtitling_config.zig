const AspectRatio = @import("aspect_ratio.zig").AspectRatio;
const TranscriptionLanguage = @import("transcription_language.zig").TranscriptionLanguage;
const ProfanityFilterMode = @import("profanity_filter_mode.zig").ProfanityFilterMode;

/// A type of OutputConfig, used when the output in a feed is for the smart
/// subtitling feature. Smart subtitling uses automatic speech recognition (ASR)
/// to generate live TTML subtitles from the audio in your source media.
pub const SubtitlingConfig = struct {
    /// The aspect ratio of the output video, specified as width and height integer
    /// values. Elemental Inference uses the aspect ratio to determine subtitle
    /// layout and line lengths.
    aspect_ratio: ?AspectRatio = null,

    /// The ID of a custom dictionary to improve transcription accuracy for
    /// domain-specific terminology. Use the CreateDictionary operation to create a
    /// dictionary.
    dictionary: ?[]const u8 = null,

    /// The language of the audio in the source media. Elemental Inference uses this
    /// setting to optimize transcription accuracy. Specify the language using an
    /// ISO 639-2/T three-letter code, optionally with a region subtag. Supported
    /// values: eng, eng-au, eng-gb, eng-us, fra, ita, deu, spa, por.
    language: TranscriptionLanguage,

    /// Controls how profanity is handled in the generated subtitles. Valid values:
    /// DISABLED (no filtering, default), CENSOR (replace profanity with asterisks),
    /// DROP (remove profanity from the transcript).
    profanity_filter: ?ProfanityFilterMode = null,

    pub const json_field_names = .{
        .aspect_ratio = "aspectRatio",
        .dictionary = "dictionary",
        .language = "language",
        .profanity_filter = "profanityFilter",
    };
};
