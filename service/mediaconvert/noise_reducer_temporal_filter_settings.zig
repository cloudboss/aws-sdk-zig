const NoiseFilterPostTemporalSharpening = @import("noise_filter_post_temporal_sharpening.zig").NoiseFilterPostTemporalSharpening;
const NoiseFilterPostTemporalSharpeningStrength = @import("noise_filter_post_temporal_sharpening_strength.zig").NoiseFilterPostTemporalSharpeningStrength;

/// Noise reducer filter settings for temporal filter.
pub const NoiseReducerTemporalFilterSettings = struct {
    /// Use Aggressive mode for content that has complex motion. Higher values
    /// produce stronger temporal filtering. This filters highly complex scenes more
    /// aggressively and creates better VQ for low bitrate outputs.
    aggressive_mode: ?i32 = null,

    /// When you set Noise reducer to Temporal, the bandwidth and sharpness of your
    /// output is reduced. You can optionally use Post temporal sharpening to apply
    /// sharpening to the edges of your output. Note that Post temporal sharpening
    /// will also make the bandwidth reduction from the Noise reducer smaller. The
    /// default behavior, Auto, allows the transcoder to determine whether to apply
    /// sharpening, depending on your input type and quality. When you set Post
    /// temporal sharpening to Enabled, specify how much sharpening is applied using
    /// Post temporal sharpening strength. Set Post temporal sharpening to Disabled
    /// to not apply sharpening.
    post_temporal_sharpening: ?NoiseFilterPostTemporalSharpening = null,

    /// Use Post temporal sharpening strength to define the amount of sharpening the
    /// transcoder applies to your output. Set Post temporal sharpening strength to
    /// Low, Medium, or High to indicate the amount of sharpening.
    post_temporal_sharpening_strength: ?NoiseFilterPostTemporalSharpeningStrength = null,

    /// The speed of the filter (higher number is faster). Low setting reduces bit
    /// rate at the cost of transcode time, high setting improves transcode time at
    /// the cost of bit rate.
    speed: ?i32 = null,

    /// Specify the strength of the noise reducing filter on this output. Higher
    /// values produce stronger filtering. We recommend the following value ranges,
    /// depending on the result that you want: * 0-2 for complexity reduction with
    /// minimal sharpness loss * 2-8 for complexity reduction with image
    /// preservation * 8-16 for a high level of complexity reduction
    strength: ?i32 = null,

    pub const json_field_names = .{
        .aggressive_mode = "AggressiveMode",
        .post_temporal_sharpening = "PostTemporalSharpening",
        .post_temporal_sharpening_strength = "PostTemporalSharpeningStrength",
        .speed = "Speed",
        .strength = "Strength",
    };
};
