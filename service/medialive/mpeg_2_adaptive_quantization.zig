/// Mpeg2 Adaptive Quantization
pub const Mpeg2AdaptiveQuantization = enum {
    auto,
    high,
    low,
    medium,
    off,

    pub const json_field_names = .{
        .auto = "AUTO",
        .high = "HIGH",
        .low = "LOW",
        .medium = "MEDIUM",
        .off = "OFF",
    };
};
