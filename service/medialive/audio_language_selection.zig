const AudioLanguageSelectionPolicy = @import("audio_language_selection_policy.zig").AudioLanguageSelectionPolicy;

/// Audio Language Selection
pub const AudioLanguageSelection = struct {
    /// Selects a specific three-letter language code from within an audio source.
    language_code: []const u8,

    /// When set to "strict", the transport stream demux strictly identifies audio
    /// streams by their language descriptor. If a PMT update occurs such that an
    /// audio stream matching the initially selected language is no longer present
    /// then mute will be encoded until the language returns. If "loose", then on a
    /// PMT update the demux will choose another audio stream in the program with
    /// the same stream type if it can't find one with the same language.
    language_selection_policy: ?AudioLanguageSelectionPolicy = null,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .language_selection_policy = "LanguageSelectionPolicy",
    };
};
