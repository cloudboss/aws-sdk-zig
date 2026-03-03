const BandwidthReductionPostFilterSharpening = @import("bandwidth_reduction_post_filter_sharpening.zig").BandwidthReductionPostFilterSharpening;
const BandwidthReductionFilterStrength = @import("bandwidth_reduction_filter_strength.zig").BandwidthReductionFilterStrength;

/// Bandwidth Reduction Filter Settings
pub const BandwidthReductionFilterSettings = struct {
    /// Configures the sharpening control, which is available when the bandwidth
    /// reduction filter is enabled. This
    /// control sharpens edges and contours, which produces a specific artistic
    /// effect that you might want.
    ///
    /// We recommend that you test each of the values (including DISABLED) to
    /// observe the sharpening effect on the
    /// content.
    post_filter_sharpening: ?BandwidthReductionPostFilterSharpening = null,

    /// Enables the bandwidth reduction filter. The filter strengths range from 1 to
    /// 4. We recommend that you always
    /// enable this filter and use AUTO, to let MediaLive apply the optimum
    /// filtering for the context.
    strength: ?BandwidthReductionFilterStrength = null,

    pub const json_field_names = .{
        .post_filter_sharpening = "PostFilterSharpening",
        .strength = "Strength",
    };
};
