const BandwidthReductionFilterSharpening = @import("bandwidth_reduction_filter_sharpening.zig").BandwidthReductionFilterSharpening;
const BandwidthReductionFilterStrength = @import("bandwidth_reduction_filter_strength.zig").BandwidthReductionFilterStrength;

/// The Bandwidth reduction filter increases the video quality of your output
/// relative to its bitrate. Use to lower the bitrate of your constant quality
/// QVBR output, with little or no perceptual decrease in quality. Or, use to
/// increase the video quality of outputs with other rate control modes relative
/// to the bitrate that you specify. Bandwidth reduction increases further when
/// your input is low quality or noisy. Outputs that use this feature incur
/// pro-tier pricing. When you include Bandwidth reduction filter, you cannot
/// include the Noise reducer preprocessor.
pub const BandwidthReductionFilter = struct {
    /// Optionally specify the level of sharpening to apply when you use the
    /// Bandwidth reduction filter. Sharpening adds contrast to the edges of your
    /// video content and can reduce softness. Keep the default value Off to apply
    /// no sharpening. Set Sharpening strength to Low to apply a minimal amount of
    /// sharpening, or High to apply a maximum amount of sharpening.
    sharpening: ?BandwidthReductionFilterSharpening,

    /// Specify the strength of the Bandwidth reduction filter. For most workflows,
    /// we recommend that you choose Auto to reduce the bandwidth of your output
    /// with little to no perceptual decrease in video quality. For high quality and
    /// high bitrate outputs, choose Low. For the most bandwidth reduction, choose
    /// High. We recommend that you choose High for low bitrate outputs. Note that
    /// High may incur a slight increase in the softness of your output.
    strength: ?BandwidthReductionFilterStrength,

    pub const json_field_names = .{
        .sharpening = "Sharpening",
        .strength = "Strength",
    };
};
