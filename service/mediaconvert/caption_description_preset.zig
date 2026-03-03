const CaptionDestinationSettings = @import("caption_destination_settings.zig").CaptionDestinationSettings;
const LanguageCode = @import("language_code.zig").LanguageCode;

/// Caption Description for preset
pub const CaptionDescriptionPreset = struct {
    /// Specify the language for this captions output track. For most captions
    /// output formats, the encoder puts this language information in the output
    /// captions metadata. If your output captions format is DVB-Sub or Burn in, the
    /// encoder uses this language information when automatically selecting the font
    /// script for rendering the captions text. For all outputs, you can use an ISO
    /// 639-2 or ISO 639-3 code. For streaming outputs, you can also use any other
    /// code in the full RFC-5646 specification. Streaming outputs are those that
    /// are in one of the following output groups: CMAF, DASH ISO, Apple HLS, or
    /// Microsoft Smooth Streaming.
    custom_language_code: ?[]const u8 = null,

    /// Settings related to one captions tab on the MediaConvert console. Usually,
    /// one captions tab corresponds to one output captions track. Depending on your
    /// output captions format, one tab might correspond to a set of output captions
    /// tracks. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/including-captions.html.
    destination_settings: ?CaptionDestinationSettings = null,

    /// Specify the language of this captions output track. For most captions output
    /// formats, the encoder puts this language information in the output captions
    /// metadata. If your output captions format is DVB-Sub or Burn in, the encoder
    /// uses this language information to choose the font language for rendering the
    /// captions text.
    language_code: ?LanguageCode = null,

    /// Specify a label for this set of output captions. For example, "English",
    /// "Director commentary", or "track_2". For streaming outputs, MediaConvert
    /// passes this information into destination manifests for display on the
    /// end-viewer's player device. For outputs in other output groups, the service
    /// ignores this setting.
    language_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_language_code = "CustomLanguageCode",
        .destination_settings = "DestinationSettings",
        .language_code = "LanguageCode",
        .language_description = "LanguageDescription",
    };
};
