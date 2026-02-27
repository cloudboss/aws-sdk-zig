/// When you set Adaptive Quantization to Auto, or leave blank, MediaConvert
/// automatically applies quantization to improve the video quality of your
/// output. Set Adaptive Quantization to Low, Medium, High, Higher, or Max to
/// manually control the strength of the quantization filter. When you do, you
/// can specify a value for Spatial Adaptive Quantization, Temporal Adaptive
/// Quantization, and Flicker Adaptive Quantization, to further control the
/// quantization filter. Set Adaptive Quantization to Off to apply no
/// quantization to your output.
pub const H265AdaptiveQuantization = enum {
    off,
    low,
    medium,
    high,
    higher,
    max,
    auto,

    pub const json_field_names = .{
        .off = "OFF",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .higher = "HIGHER",
        .max = "MAX",
        .auto = "AUTO",
    };
};
