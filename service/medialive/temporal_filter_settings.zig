const TemporalFilterPostFilterSharpening = @import("temporal_filter_post_filter_sharpening.zig").TemporalFilterPostFilterSharpening;
const TemporalFilterStrength = @import("temporal_filter_strength.zig").TemporalFilterStrength;

/// Temporal Filter Settings
pub const TemporalFilterSettings = struct {
    /// If you enable this filter, the results are the following:
    /// - If the source content is noisy (it contains excessive digital artifacts),
    /// the filter cleans up the source.
    /// - If the source content is already clean, the filter tends to decrease the
    /// bitrate, especially when the rate control mode is QVBR.
    post_filter_sharpening: ?TemporalFilterPostFilterSharpening,

    /// Choose a filter strength. We recommend a strength of 1 or 2. A higher
    /// strength might take out good information, resulting in an image that is
    /// overly soft.
    strength: ?TemporalFilterStrength,

    pub const json_field_names = .{
        .post_filter_sharpening = "PostFilterSharpening",
        .strength = "Strength",
    };
};
