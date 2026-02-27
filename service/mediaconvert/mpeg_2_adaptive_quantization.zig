/// Specify the strength of any adaptive quantization filters that you enable.
/// The value that you choose here applies to the following settings: Spatial
/// adaptive quantization, and Temporal adaptive quantization.
pub const Mpeg2AdaptiveQuantization = enum {
    off,
    low,
    medium,
    high,

    pub const json_field_names = .{
        .off = "OFF",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };
};
