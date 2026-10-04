const EnabledOrDisabledState = @import("enabled_or_disabled_state.zig").EnabledOrDisabledState;

/// Configuration for audio extraction.
pub const AudioExtractionConfiguration = struct {
    /// Whether audio extraction is enabled or disabled.
    audio_extraction_status: EnabledOrDisabledState,

    pub const json_field_names = .{
        .audio_extraction_status = "audioExtractionStatus",
    };
};
