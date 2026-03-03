const SrtStylePassthrough = @import("srt_style_passthrough.zig").SrtStylePassthrough;

/// Settings related to SRT captions. SRT is a sidecar format that holds
/// captions in a file that is separate from the video container. Set up sidecar
/// captions in the same output group, but different output from your video.
pub const SrtDestinationSettings = struct {
    /// Set Style passthrough to ENABLED to use the available style, color, and
    /// position information from your input captions. MediaConvert uses default
    /// settings for any missing style and position information in your input
    /// captions. Set Style passthrough to DISABLED, or leave blank, to ignore the
    /// style and position information from your input captions and use simplified
    /// output captions.
    style_passthrough: ?SrtStylePassthrough = null,

    pub const json_field_names = .{
        .style_passthrough = "StylePassthrough",
    };
};
