const ColorCorrector = @import("color_corrector.zig").ColorCorrector;
const Deinterlacer = @import("deinterlacer.zig").Deinterlacer;
const DolbyVision = @import("dolby_vision.zig").DolbyVision;
const Hdr10Plus = @import("hdr_10_plus.zig").Hdr10Plus;
const ImageInserter = @import("image_inserter.zig").ImageInserter;
const NoiseReducer = @import("noise_reducer.zig").NoiseReducer;
const PartnerWatermarking = @import("partner_watermarking.zig").PartnerWatermarking;
const TimecodeBurnin = @import("timecode_burnin.zig").TimecodeBurnin;

/// Find additional transcoding features under Preprocessors. Enable the
/// features at each output individually. These features are disabled by
/// default.
pub const VideoPreprocessor = struct {
    /// Use these settings to convert the color space or to modify properties such
    /// as hue and contrast for this output. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/converting-the-color-space.html.
    color_corrector: ?ColorCorrector,

    /// Use the deinterlacer to produce smoother motion and a clearer picture. For
    /// more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/working-with-scan-type.html.
    deinterlacer: ?Deinterlacer,

    /// Enable Dolby Vision feature to produce Dolby Vision compatible video output.
    dolby_vision: ?DolbyVision,

    /// Enable HDR10+ analysis and metadata injection. Compatible with HEVC only.
    hdr_10_plus: ?Hdr10Plus,

    /// Enable the Image inserter feature to include a graphic overlay on your
    /// video. Enable or disable this feature for each output individually. This
    /// setting is disabled by default.
    image_inserter: ?ImageInserter,

    /// Enable the Noise reducer feature to remove noise from your video output if
    /// necessary. Enable or disable this feature for each output individually. This
    /// setting is disabled by default. When you enable Noise reducer, you must also
    /// select a value for Noise reducer filter. For AVC outputs, when you include
    /// Noise reducer, you cannot include the Bandwidth reduction filter.
    noise_reducer: ?NoiseReducer,

    /// If you work with a third party video watermarking partner, use the group of
    /// settings that correspond with your watermarking partner to include
    /// watermarks in your output.
    partner_watermarking: ?PartnerWatermarking,

    /// Settings for burning the output timecode and specified prefix into the
    /// output.
    timecode_burnin: ?TimecodeBurnin,

    pub const json_field_names = .{
        .color_corrector = "ColorCorrector",
        .deinterlacer = "Deinterlacer",
        .dolby_vision = "DolbyVision",
        .hdr_10_plus = "Hdr10Plus",
        .image_inserter = "ImageInserter",
        .noise_reducer = "NoiseReducer",
        .partner_watermarking = "PartnerWatermarking",
        .timecode_burnin = "TimecodeBurnin",
    };
};
