/// Keep the default value, Auto, for this setting to have MediaConvert
/// automatically apply the best types of quantization for your video content.
/// When you want to apply your quantization settings manually, you must set
/// Adaptive quantization to a value other than Auto. Use this setting to
/// specify the strength of any adaptive quantization filters that you enable.
/// If you don't want MediaConvert to do any adaptive quantization in this
/// transcode, set Adaptive quantization to Off. Related settings: The value
/// that you choose here applies to the following settings: Flicker adaptive
/// quantization (flickerAdaptiveQuantization), Spatial adaptive quantization,
/// and Temporal adaptive quantization.
pub const XavcAdaptiveQuantization = enum {
    off,
    auto,
    low,
    medium,
    high,
    higher,
    max,

    pub const json_field_names = .{
        .off = "OFF",
        .auto = "AUTO",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .higher = "HIGHER",
        .max = "MAX",
    };
};
