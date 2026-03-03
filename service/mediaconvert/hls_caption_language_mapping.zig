const LanguageCode = @import("language_code.zig").LanguageCode;

/// Caption Language Mapping
pub const HlsCaptionLanguageMapping = struct {
    /// Caption channel.
    caption_channel: ?i32 = null,

    /// Specify the language, using an ISO 639-2 three-letter code in all capital
    /// letters. You can find a list of codes at:
    /// https://www.loc.gov/standards/iso639-2/php/code_list.php
    custom_language_code: ?[]const u8 = null,

    /// Specify the language, using an ISO 639-2 three-letter code in all capital
    /// letters. You can find a list of codes at:
    /// https://www.loc.gov/standards/iso639-2/php/code_list.php
    language_code: ?LanguageCode = null,

    /// Caption language description.
    language_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .caption_channel = "CaptionChannel",
        .custom_language_code = "CustomLanguageCode",
        .language_code = "LanguageCode",
        .language_description = "LanguageDescription",
    };
};
