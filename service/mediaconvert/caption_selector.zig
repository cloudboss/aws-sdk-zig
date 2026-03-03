const LanguageCode = @import("language_code.zig").LanguageCode;
const CaptionSourceSettings = @import("caption_source_settings.zig").CaptionSourceSettings;

/// Use captions selectors to specify the captions data from your input that you
/// use in your outputs. You can use up to 100 captions selectors per input.
pub const CaptionSelector = struct {
    /// The specific language to extract from source, using the ISO 639-2 or ISO
    /// 639-3 three-letter language code. If input is SCTE-27, complete this field
    /// and/or PID to select the caption language to extract. If input is DVB-Sub
    /// and output is Burn-in, complete this field and/or PID to select the caption
    /// language to extract. If input is DVB-Sub that is being passed through, omit
    /// this field (and PID field); there is no way to extract a specific language
    /// with pass-through captions.
    custom_language_code: ?[]const u8 = null,

    /// The specific language to extract from source. If input is SCTE-27, complete
    /// this field and/or PID to select the caption language to extract. If input is
    /// DVB-Sub and output is Burn-in, complete this field and/or PID to select the
    /// caption language to extract. If input is DVB-Sub that is being passed
    /// through, omit this field (and PID field); there is no way to extract a
    /// specific language with pass-through captions.
    language_code: ?LanguageCode = null,

    /// If your input captions are SCC, TTML, STL, SMI, SRT, or IMSC in an xml file,
    /// specify the URI of the input captions source file. If your input captions
    /// are IMSC in an IMF package, use TrackSourceSettings instead of
    /// FileSoureSettings.
    source_settings: ?CaptionSourceSettings = null,

    pub const json_field_names = .{
        .custom_language_code = "CustomLanguageCode",
        .language_code = "LanguageCode",
        .source_settings = "SourceSettings",
    };
};
