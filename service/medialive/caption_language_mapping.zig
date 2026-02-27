/// Maps a caption channel to an ISO 693-2 language code
/// (http://www.loc.gov/standards/iso639-2), with an optional description.
pub const CaptionLanguageMapping = struct {
    /// The closed caption channel being described by this CaptionLanguageMapping.
    /// Each channel mapping must have a unique channel number (maximum of 4)
    caption_channel: i32,

    /// Three character ISO 639-2 language code (see
    /// http://www.loc.gov/standards/iso639-2)
    language_code: []const u8,

    /// Textual description of language
    language_description: []const u8,

    pub const json_field_names = .{
        .caption_channel = "CaptionChannel",
        .language_code = "LanguageCode",
        .language_description = "LanguageDescription",
    };
};
