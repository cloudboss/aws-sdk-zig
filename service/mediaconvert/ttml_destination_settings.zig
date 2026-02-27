const TtmlStylePassthrough = @import("ttml_style_passthrough.zig").TtmlStylePassthrough;

/// Settings related to TTML captions. TTML is a sidecar format that holds
/// captions in a file that is separate from the video container. Set up sidecar
/// captions in the same output group, but different output from your video. For
/// more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/ttml-and-webvtt-output-captions.html.
pub const TtmlDestinationSettings = struct {
    /// Pass through style and position information from a TTML-like input source
    /// (TTML, IMSC, SMPTE-TT) to the TTML output.
    style_passthrough: ?TtmlStylePassthrough,

    pub const json_field_names = .{
        .style_passthrough = "StylePassthrough",
    };
};
