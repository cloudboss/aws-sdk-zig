/// Add an array item for each language. Follow the order of the caption
/// descriptions. For example, if the first caption description is for German,
/// then the first array item must be for German, and its caption channel must
/// be set to 1. The second array item must be 2, and so on.
pub const CmafIngestCaptionLanguageMapping = struct {
    /// A number for the channel for this caption, 1 to 4.
    caption_channel: i32,

    /// Language code for the language of the caption in this channel. For example,
    /// ger/deu. See http://www.loc.gov/standards/iso639-2
    language_code: []const u8,

    pub const json_field_names = .{
        .caption_channel = "CaptionChannel",
        .language_code = "LanguageCode",
    };
};
