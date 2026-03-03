const AudioSelectorSettings = @import("audio_selector_settings.zig").AudioSelectorSettings;

/// Audio Selector
pub const AudioSelector = struct {
    /// The name of this AudioSelector. AudioDescriptions will use this name to
    /// uniquely identify this Selector. Selector names should be unique per input.
    name: []const u8,

    /// The audio selector settings.
    selector_settings: ?AudioSelectorSettings = null,

    pub const json_field_names = .{
        .name = "Name",
        .selector_settings = "SelectorSettings",
    };
};
