const EnabledOrDisabledState = @import("enabled_or_disabled_state.zig").EnabledOrDisabledState;

/// Configuration for video extraction.
pub const VideoExtractionConfiguration = struct {
    /// Whether video extraction is enabled or disabled.
    video_extraction_status: EnabledOrDisabledState,

    pub const json_field_names = .{
        .video_extraction_status = "videoExtractionStatus",
    };
};
