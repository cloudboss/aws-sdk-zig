/// Specify the strength of any adaptive quantization filters that you enable.
/// The value that you choose here applies to Spatial adaptive quantization.
pub const Av1AdaptiveQuantization = enum {
    off,
    low,
    medium,
    high,
    higher,
    max,

    pub const json_field_names = .{
        .off = "OFF",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .higher = "HIGHER",
        .max = "MAX",
    };
};
