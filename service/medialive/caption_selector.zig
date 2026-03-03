const CaptionSelectorSettings = @import("caption_selector_settings.zig").CaptionSelectorSettings;

/// Caption Selector
pub const CaptionSelector = struct {
    /// When specified this field indicates the three letter language code of the
    /// caption track to extract from the source.
    language_code: ?[]const u8 = null,

    /// Name identifier for a caption selector. This name is used to associate this
    /// caption selector with one or more caption descriptions. Names must be unique
    /// within an event.
    name: []const u8,

    /// Caption selector settings.
    selector_settings: ?CaptionSelectorSettings = null,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .name = "Name",
        .selector_settings = "SelectorSettings",
    };
};
